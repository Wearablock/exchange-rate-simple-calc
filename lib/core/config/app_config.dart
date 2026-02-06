import 'dart:io';
import 'package:flutter/material.dart';

class AppConfig {
  AppConfig._();

  // ============================================================
  // 앱 기본 정보
  // ============================================================
  static const String appName = 'Easy Exchange';
  static const String appId = 'com.example.exchange_rate_simple_calc';

  // ============================================================
  // 브랜드 색상
  // ============================================================
  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color primaryDarkColor = Color(0xFF388E3C);
  static const Color primaryLightColor = Color(0xFF81C784);

  static const Color secondaryColor = Color(0xFF2196F3);
  static const Color secondaryLightColor = Color(0xFF64B5F6);

  static const Color surfaceLightColor = Color(0xFFFAFAFA);
  static const Color surfaceDarkColor = Color(0xFF121212);

  static const Color positiveColor = Color(0xFF4CAF50);
  static const Color negativeColor = Color(0xFFF44336);
  static const Color neutralColor = Color(0xFF9E9E9E);

  // ============================================================
  // 지원 언어
  // ============================================================
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ko'),
    Locale('ja'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    Locale('de'),
    Locale('fr'),
    Locale('es'),
    Locale('pt'),
    Locale('it'),
    Locale('ru'),
    Locale('ar'),
    Locale('th'),
    Locale('vi'),
    Locale('id'),
  ];

  // ============================================================
  // 캐시 설정
  // ============================================================
  static const Duration memoryCacheExpiry = Duration(hours: 1);
  static const Duration localCacheExpiry = Duration(hours: 24);

  // ============================================================
  // 광고 설정 (AdMob)
  // ============================================================

  // 테스트 광고 ID
  static const String _testBannerIdAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const String _testBannerIdIOS = 'ca-app-pub-3940256099942544/2934735716';
  static const String _testInterstitialIdAndroid = 'ca-app-pub-3940256099942544/1033173712';
  static const String _testInterstitialIdIOS = 'ca-app-pub-3940256099942544/4411468910';
  static const String _testRewardedIdAndroid = 'ca-app-pub-3940256099942544/5224354917';
  static const String _testRewardedIdIOS = 'ca-app-pub-3940256099942544/1712485313';

  // 프로덕션 광고 ID
  static const String _prodBannerIdAndroid = 'ca-app-pub-8841058711613546/8750577075';
  static const String _prodBannerIdIOS = 'ca-app-pub-8841058711613546/6946550559';
  static const String _prodInterstitialIdAndroid = 'ca-app-pub-8841058711613546/6124413732';
  static const String _prodInterstitialIdIOS = 'ca-app-pub-8841058711613546/8259622487';
  static const String _prodRewardedIdAndroid = 'ca-app-pub-8841058711613546/2185168726';
  static const String _prodRewardedIdIOS = 'ca-app-pub-8841058711613546/4396408830';

  // 플랫폼별 광고 ID 반환
  static String getBannerId({required bool isTestMode}) {
    if (isTestMode) {
      return Platform.isAndroid ? _testBannerIdAndroid : _testBannerIdIOS;
    }
    return Platform.isAndroid ? _prodBannerIdAndroid : _prodBannerIdIOS;
  }

  static String getInterstitialId({required bool isTestMode}) {
    if (isTestMode) {
      return Platform.isAndroid ? _testInterstitialIdAndroid : _testInterstitialIdIOS;
    }
    return Platform.isAndroid ? _prodInterstitialIdAndroid : _prodInterstitialIdIOS;
  }

  static String getRewardedId({required bool isTestMode}) {
    if (isTestMode) {
      return Platform.isAndroid ? _testRewardedIdAndroid : _testRewardedIdIOS;
    }
    return Platform.isAndroid ? _prodRewardedIdAndroid : _prodRewardedIdIOS;
  }

  // ============================================================
  // 인앱결제 설정 (IAP)
  // ============================================================
  static const String removeAdsProductId = 'exchange_rate_simple_calc_remove_ads';

  // ============================================================
  // 외부 URL
  // ============================================================
  static const String _baseDocsUrl = 'https://wearablock.github.io/exchange_rate_simple_calc';
  static const String termsUrl = '$_baseDocsUrl/terms.html';
  static const String privacyUrl = '$_baseDocsUrl/privacy.html';
  static const String supportUrl = '$_baseDocsUrl/support.html';
}
