import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

class IAPService {
  static final IAPService _instance = IAPService._internal();
  factory IAPService() => _instance;
  IAPService._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  List<ProductDetails> _products = [];
  bool _isPremium = false;

  static const String _premiumKey = 'is_premium';

  bool get isPremium => _isPremium;
  List<ProductDetails> get products => _products;

  // 프리미엄 상태 변경 스트림
  final _premiumStatusController = StreamController<bool>.broadcast();
  Stream<bool> get premiumStatusStream => _premiumStatusController.stream;

  Future<void> initialize() async {
    final available = await _iap.isAvailable();
    if (!available) {
      debugPrint('[IAPService] IAP 사용 불가');
      return;
    }

    // 저장된 프리미엄 상태 로드
    await _loadPremiumStatus();

    // 구매 스트림 리스닝
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdated,
      onError: (error) => debugPrint('[IAPService] 오류: $error'),
    );

    // 상품 정보 로드
    await loadProducts();
  }

  Future<void> _loadPremiumStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isPremium = prefs.getBool(_premiumKey) ?? false;
    _premiumStatusController.add(_isPremium);
  }

  Future<void> _savePremiumStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_premiumKey, value);
    _isPremium = value;
    _premiumStatusController.add(_isPremium);
  }

  Future<void> loadProducts() async {
    const productIds = <String>{AppConfig.removeAdsProductId};
    final response = await _iap.queryProductDetails(productIds);

    if (response.error != null) {
      debugPrint('[IAPService] 상품 조회 오류: ${response.error}');
      return;
    }

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('[IAPService] 찾을 수 없는 상품: ${response.notFoundIDs}');
    }

    _products = response.productDetails;
    debugPrint('[IAPService] 상품 로드 완료: ${_products.length}개');
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      _handlePurchase(purchase);
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchase) async {
    if (purchase.status == PurchaseStatus.pending) {
      debugPrint('[IAPService] 구매 대기 중...');
      return;
    }

    if (purchase.status == PurchaseStatus.error) {
      debugPrint('[IAPService] 구매 오류: ${purchase.error}');
      return;
    }

    if (purchase.status == PurchaseStatus.purchased ||
        purchase.status == PurchaseStatus.restored) {
      // 구매 완료 처리
      if (purchase.productID == AppConfig.removeAdsProductId) {
        await _savePremiumStatus(true);
        debugPrint('[IAPService] 프리미엄 활성화');
      }
    }

    // 구매 완료 확인 (필수)
    if (purchase.pendingCompletePurchase) {
      await _iap.completePurchase(purchase);
    }
  }

  Future<bool> buyRemoveAds() async {
    try {
      final product = _products.firstWhere(
        (p) => p.id == AppConfig.removeAdsProductId,
      );

      final purchaseParam = PurchaseParam(productDetails: product);
      return await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      debugPrint('[IAPService] 구매 실패: $e');
      return false;
    }
  }

  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  void dispose() {
    _subscription?.cancel();
    _premiumStatusController.close();
  }
}
