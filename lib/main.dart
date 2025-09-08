import 'package:flutter/material.dart';
import 'package:guardara/screens/password_screen.dart';
import 'package:guardara/viewmodels/password_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GuardaraApp());
}

class GuardaraApp extends StatelessWidget {
  const GuardaraApp({super.key});

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PasswordViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Guardara',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF4F46E5)
        ),
        home: const PasswordScreen(),
      ),
    );
  }
}