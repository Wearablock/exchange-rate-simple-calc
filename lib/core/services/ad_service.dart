import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import '../config/app_config.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  bool _isInitialized = false;
  bool _isPremium = false;
  DateTime? _lastInterstitialTime;

  static const Duration _minInterstitialInterval = Duration(seconds: 60);

  // 테스트 모드 (Debug 빌드에서만)
  bool get isTestMode => kDebugMode;

  bool get isRewardedAdReady => _rewardedAd != null;
  BannerAd? get bannerAd => _isPremium ? null : _bannerAd;

  Future<void> initialize() async {
    if (_isInitialized) return;

    // iOS ATT 권한 요청
    if (Platform.isIOS) {
      await _requestATTPermission();
    }

    await MobileAds.instance.initialize();
    _isInitialized = true;
    debugPrint('[AdService] 초기화 완료');

    // 광고 미리 로드
    if (!_isPremium) {
      await loadBannerAd();
      await loadInterstitialAd();
    }
    await loadRewardedAd();
  }

  Future<void> _requestATTPermission() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  void setPremiumStatus(bool isPremium) {
    _isPremium = isPremium;
    if (_isPremium) {
      _bannerAd?.dispose();
      _bannerAd = null;
      _interstitialAd?.dispose();
      _interstitialAd = null;
    }
  }

  // ============================================================
  // Banner Ad
  // ============================================================
  Future<void> loadBannerAd() async {
    if (_isPremium) return;

    _bannerAd?.dispose();
    _bannerAd = BannerAd(
      adUnitId: AppConfig.getBannerId(isTestMode: isTestMode),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => debugPrint('[AdService] 배너 광고 로드 완료'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
          debugPrint('[AdService] 배너 광고 로드 실패: ${error.message}');
        },
      ),
    );
    await _bannerAd?.load();
  }

  // ============================================================
  // Interstitial Ad
  // ============================================================
  Future<void> loadInterstitialAd() async {
    if (_isPremium) return;

    await InterstitialAd.load(
      adUnitId: AppConfig.getInterstitialId(isTestMode: isTestMode),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          debugPrint('[AdService] 전면 광고 로드 완료');
        },
        onAdFailedToLoad: (error) {
          _interstitialAd = null;
          debugPrint('[AdService] 전면 광고 로드 실패: ${error.message}');
        },
      ),
    );
  }

  Future<bool> showInterstitialAd() async {
    if (_isPremium || _interstitialAd == null) return false;

    // 최소 간격 체크
    if (_lastInterstitialTime != null) {
      final elapsed = DateTime.now().difference(_lastInterstitialTime!);
      if (elapsed < _minInterstitialInterval) return false;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
        loadInterstitialAd();
      },
    );

    await _interstitialAd!.show();
    _lastInterstitialTime = DateTime.now();
    _interstitialAd = null;
    return true;
  }

  // ============================================================
  // Rewarded Ad
  // ============================================================
  Future<void> loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: AppConfig.getRewardedId(isTestMode: isTestMode),
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          debugPrint('[AdService] 리워드 광고 로드 완료');
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          debugPrint('[AdService] 리워드 광고 로드 실패: ${error.message}');
        },
      ),
    );
  }

  Future<bool> showRewardedAd({required Function(int) onRewarded}) async {
    if (_rewardedAd == null) {
      debugPrint('[AdService] 리워드 광고가 준비되지 않음');
      return false;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _rewardedAd = null;
        loadRewardedAd();
      },
    );

    await _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        debugPrint('[AdService] 리워드 획득: ${reward.amount} ${reward.type}');
        onRewarded(reward.amount.toInt());
      },
    );
    _rewardedAd = null;
    return true;
  }

  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }
}
