class Currency {
  final String code;
  final String name;
  final String nameKo;
  final String symbol;
  final String flag;
  final int decimalPlaces;
  /// 환율 표시 기준 단위 (예: KRW=1000, JPY=100, USD=1)
  final int baseUnit;

  const Currency({
    required this.code,
    required this.name,
    required this.nameKo,
    required this.symbol,
    required this.flag,
    this.decimalPlaces = 2,
    this.baseUnit = 1,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Currency &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => 'Currency($code)';
}
