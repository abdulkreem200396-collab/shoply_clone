import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// غلاف بسيط حول SharedPreferences: كل التخزين المحلي بمكان واحد
class LocalStorage {
  LocalStorage._();

  static final LocalStorage instance = LocalStorage._();

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get seenOnboarding => _prefs.getBool('seenOnboarding') ?? false;

  Future<void> setSeenOnboarding(bool value) {
    return _prefs.setBool('seenOnboarding', value);
  }

  // الخيارات: dark أو light أو system (الافتراضي: حسب الجهاز)
  ThemeMode get themeMode {
    final saved = _prefs.getString('themeMode');
    for (final mode in ThemeMode.values) {
      if (mode.name == saved) return mode;
    }

    // النسخة القديمة كانت بتحفظ isDark، فمنحترم اختيار المستخدم القديم
    final legacy = _prefs.getBool('isDark');
    if (legacy != null) return legacy ? ThemeMode.dark : ThemeMode.light;

    return ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) {
    return _prefs.setString('themeMode', mode.name);
  }
}
