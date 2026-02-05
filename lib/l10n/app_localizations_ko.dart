// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => '홈';

  @override
  String get history => '기록';

  @override
  String get settings => '설정';

  @override
  String get baseCurrency => '기준 통화';

  @override
  String get targetCurrencies => '관심 통화';

  @override
  String get lastUpdated => '마지막 업데이트';

  @override
  String minutesAgo(int minutes) {
    return '$minutes분 전';
  }

  @override
  String get justNow => '방금 전';

  @override
  String hoursAgo(int hours) {
    return '$hours시간 전';
  }

  @override
  String get saveRate => '환율 저장';

  @override
  String get savedRates => '저장된 환율';

  @override
  String get noSavedRates => '저장된 환율이 없습니다';

  @override
  String get watchAd => '광고를 보고 저장하기';

  @override
  String get rateSaved => '환율이 저장되었습니다';

  @override
  String get selectBaseCurrency => '기준 통화를 선택하세요';

  @override
  String get selectTargetCurrencies => '관심 통화를 선택하세요';

  @override
  String get getStarted => '시작하기';

  @override
  String get next => '다음';

  @override
  String get skip => '건너뛰기';

  @override
  String get refresh => '새로고침';

  @override
  String get addCurrency => '통화 추가';

  @override
  String get removeCurrency => '삭제';

  @override
  String get memo => '메모 (선택)';

  @override
  String get cancel => '취소';

  @override
  String get save => '저장';

  @override
  String get delete => '삭제';

  @override
  String get confirm => '확인';

  @override
  String get language => '언어';

  @override
  String get theme => '테마';

  @override
  String get themeSystem => '시스템';

  @override
  String get themeLight => '라이트';

  @override
  String get themeDark => '다크';

  @override
  String get removeAds => '광고 제거';

  @override
  String get removeAdsDescription => '모든 광고를 영구적으로 제거합니다';

  @override
  String get restorePurchase => '구매 복원';

  @override
  String get premium => '프리미엄';

  @override
  String get version => '버전';

  @override
  String get privacyPolicy => '개인정보처리방침';

  @override
  String get termsOfService => '이용약관';

  @override
  String get support => '지원';

  @override
  String get error => '오류';

  @override
  String get retry => '다시 시도';

  @override
  String get noInternet => '인터넷 연결이 없습니다';

  @override
  String get loadingFailed => '데이터를 불러오지 못했습니다';

  @override
  String get currencySettings => '통화 설정';

  @override
  String get appSettings => '앱 설정';

  @override
  String get about => '정보';

  @override
  String get manageCurrencies => '통화 관리';

  @override
  String get searchCurrency => '통화 검색';

  @override
  String get popular => '인기';

  @override
  String get all => '전체';

  @override
  String get deleteConfirm => '정말 삭제하시겠습니까?';

  @override
  String get adRequired => '광고 시청이 필요합니다';

  @override
  String get adNotReady => '광고가 아직 준비되지 않았습니다';

  @override
  String get saveWithoutAd => '광고 없이 저장하시겠습니까?';

  @override
  String get networkError => '네트워크 연결을 확인해주세요';
}
