import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guardara/viewmodels/password_view_model.dart';
import 'package:provider/provider.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  /// Copia a senha para a área de transferência
  Future<void> _copy(BuildContext context, String text) async {
    if (text == '-') return; // se ainda não existe senha gerada
    await Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Senha copiada!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PasswordViewModel>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Guardara - Gerar Senha')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---- CARD DE SENHA ----
          Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Senha gerada
                  SelectableText(
                    vm.current,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Botões de gerar e copiar
                  Row(
                    children: [
                      FilledButton.icon(
                        onPressed: vm.generate,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Gerar'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: () => _copy(context, vm.current),
                        icon: const Icon(Icons.copy),
                        label: const Text('Copiar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ---- TÍTULO DE PERSONALIZAÇÃO ----
          const Text(
            'Personalize sua senha',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          // ---- SLIDER DE TAMANHO ----
          Row(
            children: [
              SizedBox(
                width: 56,
                child: Text(
                  '${vm.length}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: cs.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Slider(
                  value: vm.length.toDouble(),
                  min: 6,
                  max: 64,
                  divisions: 58,
                  label: '${vm.length}',
                  onChanged: (v) => vm.setLength(v.round()),
                ),
              ),
            ],
          ),

          // ---- CHECKBOXES ----
          CheckboxListTile(
            value: vm.useUpper,
            onChanged: (v) => vm.toggleUpper(v ?? true),
            title: const Text('Letra maiúscula'),
          ),
          CheckboxListTile(
            value: vm.useLower,
            onChanged: (v) => vm.toggleLower(v ?? true),
            title: const Text('Letra minúscula'),
          ),
          CheckboxListTile(
            value: vm.useDigits,
            onChanged: (v) => vm.toggleDigits(v ?? true),
            title: const Text('Números'),
          ),
          CheckboxListTile(
            value: vm.useSymbols,
            onChanged: (v) => vm.toggleSymbols(v ?? true),
            title: const Text('Símbolos'),
          ),
        ],
      ),
    );
  }
}
