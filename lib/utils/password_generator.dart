import 'dart:math';

class PasswordGenerator {
  static const _lower   = 'abcdefghjkmnpqrstuvwxyz';   // sem i/l/o
  static const _upper   = 'ABCDEFGHJKLMNPQRSTUVWXYZ';   // sem I/L/O
  static const _digits  = '23456789';                   // sem 0/1
  static const _symbols = r'!@#$%&*?-_=+';

  static String generate({
    int length = 16,
    bool useLower = true,
    bool useUpper = true,
    bool useDigits = true,
    bool useSymbols = true,
  }) {
    final pools = <String>[];
    if (useLower)  pools.add(_lower);
    if (useUpper)  pools.add(_upper);
    if (useDigits) pools.add(_digits);
    if (useSymbols) pools.add(_symbols);
    if (pools.isEmpty) {
      throw Exception('Selecione ao menos um conjunto de caracteres.');
    }

    final rng = Random.secure();
    final all = pools.join();

    // Garante 1 de cada pool selecionada
    final out = <String>[];
    for (final p in pools) {
      out.add(p[rng.nextInt(p.length)]);
    }

    // Completa até o tamanho pedido
    while (out.length < length) {
      out.add(all[rng.nextInt(all.length)]);
    }

    // Embaralha para não ficar previsível
    out.shuffle(rng);

    return out.join();
  }
}
