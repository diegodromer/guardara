class PasswordSettings {
  final int length;
  final bool upper, lower, numbers, symbols;

  const PasswordSettings(
    {
      required this.length,
      required this.upper,
      required this.lower,
      required this.numbers,
      required this.symbols
    }
  );

  //valor padrão
  static const defaults = PasswordSettings(
    length: 16,
    upper: true,
    lower: true,
    numbers: true,
    symbols: true,
  );

  // utilzinho p/ validar: tem pelo menos um conjunto?
  bool get hasAnyPool => upper || lower || numbers || symbols;

  PasswordSettings copyWith({
    int? length,
    bool? upper,
    bool? lower,
    bool? numbers,
    bool? symbols,
  }){
    return PasswordSettings(
      length: length ?? this.length,
      upper: upper ?? this.upper,
      lower: lower ?? this.lower,
      numbers: numbers ?? this.numbers,
      symbols: symbols ?? this.symbols
    );
  }

  Map<String, dynamic> toMap() => {
    'length': length,
    'upper': upper,
    'lower': lower,
    'numbers': numbers,
    'symbols': symbols,
  };

  factory PasswordSettings.fromMap(Map map) => PasswordSettings(
    length: (map['length'] ?? 16) as int,
    upper: (map['upper'] ?? true) as bool,
    lower: (map['lower'] ?? true) as bool,
    numbers: (map['numbers'] ?? true) as bool,
    symbols: (map['symbols'] ?? true) as bool
  );

}