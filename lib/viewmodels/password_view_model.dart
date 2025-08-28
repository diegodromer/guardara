import 'package:flutter/foundation.dart';
import '../utils/password_generator.dart';

/// ViewModel da tela de geração de senhas.
/// - Mantém o estado e as regras de geração.
/// - Não depende de Widgets/BuildContext (fácil de testar).
class PasswordViewModel extends ChangeNotifier {
  // ======= Estado =======
  int length = 16;
  bool useLower = true;
  bool useUpper = true;
  bool useDigits = true;
  bool useSymbols = true;

  String current = '—';

  // Opcional: pequena métrica de força (0..4) para exibir na UI
  // (estimativa simples — podemos trocar por zxcvbn depois)
  int strengthScore = 0;

  // ======= Ações =======

  /// Gera uma nova senha com as opções atuais.
  void generate() {
    _ensureAtLeastOnePool();
    current = PasswordGenerator.generate(
      length: length,
      useLower: useLower,
      useUpper: useUpper,
      useDigits: useDigits,
      useSymbols: useSymbols,
    );
    _updateStrength();
    notifyListeners();
  }

  /// Define o tamanho, com limites mínimos/máximos.
  void setLength(int v) {
    length = v.clamp(6, 64);
    notifyListeners();
  }

  void toggleLower(bool v)  { useLower  = v; notifyListeners(); }
  void toggleUpper(bool v)  { useUpper  = v; notifyListeners(); }
  void toggleDigits(bool v) { useDigits = v; notifyListeners(); }
  void toggleSymbols(bool v){ useSymbols= v; notifyListeners(); }

  // ======= Regras internas =======

  void _ensureAtLeastOnePool() {
    if (!(useLower || useUpper || useDigits || useSymbols)) {
      throw StateError('Selecione ao menos um tipo de caractere.');
    }
  }

  // Estimativa rápida de força (0..4) baseada na diversidade e no tamanho.
  // Depois podemos trocar por zxcvbn para análise real.
  void _updateStrength() {
    int pools = 0;
    if (useLower) pools++;
    if (useUpper) pools++;
    if (useDigits) pools++;
    if (useSymbols) pools++;

    // score base por pools
    int score = pools - 1; // 0..3

    // bônus por comprimento
    if (length >= 16) score++;
    if (length >= 24) score++;

    // normaliza para 0..4
    strengthScore = score.clamp(0, 4);
  }
}
