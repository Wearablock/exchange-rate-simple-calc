import '../../data/models/currency.dart';

class Currencies {
  Currencies._();

  /// 지원하는 모든 통화
  static const List<Currency> all = [
    // 주요 통화
    Currency(code: 'USD', name: 'US Dollar', nameKo: '미국 달러', symbol: r'$', flag: '🇺🇸'),
    Currency(code: 'EUR', name: 'Euro', nameKo: '유로', symbol: '€', flag: '🇪🇺'),
    Currency(code: 'GBP', name: 'British Pound', nameKo: '영국 파운드', symbol: '£', flag: '🇬🇧'),
    Currency(code: 'JPY', name: 'Japanese Yen', nameKo: '일본 엔', symbol: '¥', flag: '🇯🇵', decimalPlaces: 0, baseUnit: 100),
    Currency(code: 'CNY', name: 'Chinese Yuan', nameKo: '중국 위안', symbol: '¥', flag: '🇨🇳'),

    // 아시아
    Currency(code: 'KRW', name: 'South Korean Won', nameKo: '한국 원', symbol: '₩', flag: '🇰🇷', decimalPlaces: 0, baseUnit: 1000),
    Currency(code: 'HKD', name: 'Hong Kong Dollar', nameKo: '홍콩 달러', symbol: r'HK$', flag: '🇭🇰'),
    Currency(code: 'TWD', name: 'Taiwan Dollar', nameKo: '대만 달러', symbol: r'NT$', flag: '🇹🇼', baseUnit: 100),
    Currency(code: 'SGD', name: 'Singapore Dollar', nameKo: '싱가포르 달러', symbol: r'S$', flag: '🇸🇬'),
    Currency(code: 'THB', name: 'Thai Baht', nameKo: '태국 바트', symbol: '฿', flag: '🇹🇭', baseUnit: 100),
    Currency(code: 'VND', name: 'Vietnamese Dong', nameKo: '베트남 동', symbol: '₫', flag: '🇻🇳', decimalPlaces: 0, baseUnit: 1000),
    Currency(code: 'IDR', name: 'Indonesian Rupiah', nameKo: '인도네시아 루피아', symbol: 'Rp', flag: '🇮🇩', decimalPlaces: 0, baseUnit: 1000),
    Currency(code: 'MYR', name: 'Malaysian Ringgit', nameKo: '말레이시아 링깃', symbol: 'RM', flag: '🇲🇾'),
    Currency(code: 'PHP', name: 'Philippine Peso', nameKo: '필리핀 페소', symbol: '₱', flag: '🇵🇭', baseUnit: 100),
    Currency(code: 'INR', name: 'Indian Rupee', nameKo: '인도 루피', symbol: '₹', flag: '🇮🇳', baseUnit: 100),

    // 오세아니아
    Currency(code: 'AUD', name: 'Australian Dollar', nameKo: '호주 달러', symbol: r'A$', flag: '🇦🇺'),
    Currency(code: 'NZD', name: 'New Zealand Dollar', nameKo: '뉴질랜드 달러', symbol: r'NZ$', flag: '🇳🇿'),

    // 유럽
    Currency(code: 'CHF', name: 'Swiss Franc', nameKo: '스위스 프랑', symbol: 'CHF', flag: '🇨🇭'),
    Currency(code: 'SEK', name: 'Swedish Krona', nameKo: '스웨덴 크로나', symbol: 'kr', flag: '🇸🇪', baseUnit: 100),
    Currency(code: 'NOK', name: 'Norwegian Krone', nameKo: '노르웨이 크로네', symbol: 'kr', flag: '🇳🇴', baseUnit: 100),
    Currency(code: 'DKK', name: 'Danish Krone', nameKo: '덴마크 크로네', symbol: 'kr', flag: '🇩🇰', baseUnit: 100),
    Currency(code: 'PLN', name: 'Polish Zloty', nameKo: '폴란드 즈워티', symbol: 'zł', flag: '🇵🇱'),
    Currency(code: 'CZK', name: 'Czech Koruna', nameKo: '체코 코루나', symbol: 'Kč', flag: '🇨🇿', baseUnit: 100),
    Currency(code: 'HUF', name: 'Hungarian Forint', nameKo: '헝가리 포린트', symbol: 'Ft', flag: '🇭🇺', decimalPlaces: 0, baseUnit: 100),
    Currency(code: 'RUB', name: 'Russian Ruble', nameKo: '러시아 루블', symbol: '₽', flag: '🇷🇺', baseUnit: 100),
    Currency(code: 'TRY', name: 'Turkish Lira', nameKo: '터키 리라', symbol: '₺', flag: '🇹🇷', baseUnit: 100),

    // 아메리카
    Currency(code: 'CAD', name: 'Canadian Dollar', nameKo: '캐나다 달러', symbol: r'C$', flag: '🇨🇦'),
    Currency(code: 'MXN', name: 'Mexican Peso', nameKo: '멕시코 페소', symbol: r'$', flag: '🇲🇽', baseUnit: 100),
    Currency(code: 'BRL', name: 'Brazilian Real', nameKo: '브라질 헤알', symbol: r'R$', flag: '🇧🇷'),
    Currency(code: 'ARS', name: 'Argentine Peso', nameKo: '아르헨티나 페소', symbol: r'$', flag: '🇦🇷', baseUnit: 1000),

    // 중동/아프리카
    Currency(code: 'AED', name: 'UAE Dirham', nameKo: 'UAE 디르함', symbol: 'د.إ', flag: '🇦🇪'),
    Currency(code: 'SAR', name: 'Saudi Riyal', nameKo: '사우디 리얄', symbol: '﷼', flag: '🇸🇦'),
    Currency(code: 'ZAR', name: 'South African Rand', nameKo: '남아공 랜드', symbol: 'R', flag: '🇿🇦', baseUnit: 100),
    Currency(code: 'EGP', name: 'Egyptian Pound', nameKo: '이집트 파운드', symbol: 'E£', flag: '🇪🇬', baseUnit: 100),
  ];

  /// 기본 관심 통화 (온보딩 시 기본 선택)
  static const List<String> defaultWatchList = [
    'KRW',
    'JPY',
    'EUR',
    'GBP',
    'CNY',
  ];

  /// 인기 통화 (기준 통화 선택 시 상단 노출)
  static const List<String> popularCurrencies = [
    'USD',
    'EUR',
    'KRW',
    'JPY',
    'GBP',
    'CNY',
    'CAD',
    'AUD',
  ];

  /// 통화 코드로 통화 정보 조회
  static Currency? getByCode(String code) {
    try {
      return all.firstWhere((c) => c.code == code);
    } catch (_) {
      return null;
    }
  }

  /// 통화 코드로 국기 이모지 조회
  static String getFlag(String code) {
    return getByCode(code)?.flag ?? '💱';
  }

  /// 통화 코드로 심볼 조회
  static String getSymbol(String code) {
    return getByCode(code)?.symbol ?? code;
  }

  /// 통화 코드로 이름 조회
  static String getName(String code, {bool korean = true}) {
    final currency = getByCode(code);
    if (currency == null) return code;
    return korean ? currency.nameKo : currency.name;
  }

  /// 소수점 자릿수 조회
  static int getDecimalPlaces(String code) {
    return getByCode(code)?.decimalPlaces ?? 2;
  }

  /// 환율 표시 기준 단위 조회 (예: KRW=1000, JPY=100, USD=1)
  static int getBaseUnit(String code) {
    return getByCode(code)?.baseUnit ?? 1;
  }

  /// 지역별 그룹화
  static Map<String, List<Currency>> get grouped => {
        '주요 통화': all.where((c) => ['USD', 'EUR', 'GBP', 'JPY', 'CNY'].contains(c.code)).toList(),
        '아시아': all.where((c) => ['KRW', 'HKD', 'TWD', 'SGD', 'THB', 'VND', 'IDR', 'MYR', 'PHP', 'INR'].contains(c.code)).toList(),
        '오세아니아': all.where((c) => ['AUD', 'NZD'].contains(c.code)).toList(),
        '유럽': all.where((c) => ['CHF', 'SEK', 'NOK', 'DKK', 'PLN', 'CZK', 'HUF', 'RUB', 'TRY'].contains(c.code)).toList(),
        '아메리카': all.where((c) => ['CAD', 'MXN', 'BRL', 'ARS'].contains(c.code)).toList(),
        '중동/아프리카': all.where((c) => ['AED', 'SAR', 'ZAR', 'EGP'].contains(c.code)).toList(),
      };

  /// 검색 (코드, 이름, 한국어 이름)
  static List<Currency> search(String query) {
    if (query.isEmpty) return all;
    final lowerQuery = query.toLowerCase();
    return all.where((c) =>
        c.code.toLowerCase().contains(lowerQuery) ||
        c.name.toLowerCase().contains(lowerQuery) ||
        c.nameKo.contains(query)).toList();
  }
}
