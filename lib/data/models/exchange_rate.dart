/// 단일 환율 정보
class ExchangeRate {
  final String baseCode;
  final String targetCode;
  final double rate;
  final DateTime timestamp;

  ExchangeRate({
    required this.baseCode,
    required this.targetCode,
    required this.rate,
    required this.timestamp,
  });

  /// 1 단위 기준 통화 = rate 단위 대상 통화
  String get formattedRate {
    if (rate >= 100) {
      return rate.toStringAsFixed(2);
    } else if (rate >= 1) {
      return rate.toStringAsFixed(4);
    } else {
      return rate.toStringAsFixed(6);
    }
  }

  /// 역환율 계산
  double get inverseRate => 1 / rate;

  @override
  String toString() => 'ExchangeRate($baseCode -> $targetCode: $rate)';
}

/// API 응답 전체 데이터
class ExchangeRateResponse {
  final String baseCode;
  final Map<String, double> rates;
  final DateTime timestamp;

  ExchangeRateResponse({
    required this.baseCode,
    required this.rates,
    required this.timestamp,
  });

  /// Frankfurter API 응답 파싱
  /// 응답 예시:
  /// {
  ///   "amount": 1,
  ///   "base": "USD",
  ///   "date": "2024-01-15",
  ///   "rates": { "KRW": 1320.45, "JPY": 145.23 }
  /// }
  factory ExchangeRateResponse.fromFrankfurterJson(Map<String, dynamic> json) {
    final dateStr = json['date'] as String;
    final dateParts = dateStr.split('-');

    return ExchangeRateResponse(
      baseCode: json['base'] as String,
      rates: Map<String, double>.from(
        (json['rates'] as Map).map(
          (key, value) => MapEntry(key, (value as num).toDouble()),
        ),
      ),
      timestamp: DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      ),
    );
  }

  /// 로컬 캐시용 JSON 변환
  Map<String, dynamic> toJson() {
    return {
      'base': baseCode,
      'date': '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}',
      'rates': rates,
    };
  }

  /// 로컬 캐시에서 복원
  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) {
    return ExchangeRateResponse.fromFrankfurterJson(json);
  }

  /// 특정 통화의 환율 조회
  ExchangeRate getRate(String targetCode) {
    return ExchangeRate(
      baseCode: baseCode,
      targetCode: targetCode,
      rate: rates[targetCode] ?? 0,
      timestamp: timestamp,
    );
  }

  /// 특정 통화의 환율 값만 조회
  double? getRateValue(String targetCode) {
    return rates[targetCode];
  }

  /// 지원하는 통화 목록
  List<String> get supportedCurrencies => rates.keys.toList();

  @override
  String toString() => 'ExchangeRateResponse($baseCode, ${rates.length} rates)';
}
