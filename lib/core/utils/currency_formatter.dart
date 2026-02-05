import 'package:intl/intl.dart';
import '../constants/currencies.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  /// 환율 포맷
  static String formatRate(double rate, String currencyCode) {
    final decimalPlaces = Currencies.getDecimalPlaces(currencyCode);

    if (rate >= 1000) {
      return NumberFormat('#,##0.##').format(rate);
    } else if (rate >= 1) {
      return rate.toStringAsFixed(decimalPlaces.clamp(2, 4));
    } else {
      return rate.toStringAsFixed(6);
    }
  }

  /// 금액 포맷 (통화 심볼 포함)
  static String formatAmount(double amount, String currencyCode) {
    final symbol = Currencies.getSymbol(currencyCode);
    final decimalPlaces = Currencies.getDecimalPlaces(currencyCode);

    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalPlaces,
    );

    return formatter.format(amount);
  }

  /// 금액 포맷 (심볼 없이, 천 단위 구분)
  static String formatAmountWithoutSymbol(double amount, String currencyCode) {
    final decimalPlaces = Currencies.getDecimalPlaces(currencyCode);

    if (decimalPlaces == 0) {
      return NumberFormat('#,##0').format(amount);
    } else {
      return NumberFormat('#,##0.${'0' * decimalPlaces}').format(amount);
    }
  }

  /// 변화율 포맷
  static String formatChangePercent(double percent) {
    final sign = percent >= 0 ? '+' : '';
    return '$sign${percent.toStringAsFixed(2)}%';
  }

  /// 간략한 금액 포맷 (1K, 1M 등)
  static String formatCompact(double amount) {
    return NumberFormat.compact().format(amount);
  }
}
