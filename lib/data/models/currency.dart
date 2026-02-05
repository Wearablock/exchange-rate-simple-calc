class Currency {
  final String code;
  final String name;
  final String nameKo;
  final String symbol;
  final String flag;
  final int decimalPlaces;

  const Currency({
    required this.code,
    required this.name,
    required this.nameKo,
    required this.symbol,
    required this.flag,
    this.decimalPlaces = 2,
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
