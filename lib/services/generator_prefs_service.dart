import 'package:guardara/models/password_settings.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GeneratorPrefsService {
  static const _box = 'prefs';
  static const _key = 'generator_settings';

  PasswordSettings load() {
    final raw = Hive.box(_box).get(_key);

    if (raw is Map) {
      return PasswordSettings.fromMap(Map<String, dynamic>.from(raw));
    }
    return PasswordSettings.defaults;
  }

  Future<void> save(PasswordSettings s) => Hive.box(_box).put(_key, s.toMap());
}
