import '../constants/currencies.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _commaRegex = RegExp(r'(\d)(?=(\d{3})+(?!\d))');

  /// 천 단위 콤마 (정수 또는 소수)
  static String formatWithComma(num value, {int decimals = 0}) {
    if (decimals == 0) {
      return value.toString().replaceAllMapped(
        _commaRegex,
        (match) => '${match[1]},',
      );
    }
    final parts = value.toStringAsFixed(decimals).split('.');
    final intPart = parts[0].replaceAllMapped(
      _commaRegex,
      (match) => '${match[1]},',
    );
    return '$intPart.${parts[1]}';
  }

  /// 환율 포맷 (통화별 소수점 자리 자동 결정)
  static String formatRate(double rate, String currencyCode) {
    final decimalPlaces = Currencies.getDecimalPlaces(currencyCode);

    if (decimalPlaces == 0) {
      return formatWithComma(rate.round());
    } else if (rate >= 100) {
      return formatWithComma(rate, decimals: 2);
    } else if (rate >= 1) {
      return rate.toStringAsFixed(4);
    } else {
      return rate.toStringAsFixed(6);
    }
  }

  /// 숫자 포맷 (정수면 콤마만, 소수면 2자리)
  static String formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.round().toString().replaceAllMapped(
        _commaRegex,
        (match) => '${match[1]},',
      );
    }
    final parts = value.toStringAsFixed(2).split('.');
    final intPart = parts[0].replaceAllMapped(
      _commaRegex,
      (match) => '${match[1]},',
    );
    return '$intPart.${parts[1]}';
  }

  /// 기준 통화 금액 표시 (예: "1,000 USD")
  static String formatBaseUnit(double amount, String currencyCode) {
    final display = amount == amount.roundToDouble()
        ? amount.round().toString().replaceAllMapped(
              _commaRegex,
              (match) => '${match[1]},',
            )
        : amount.toStringAsFixed(2);
    return '$display $currencyCode';
  }
}
