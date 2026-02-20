// Place Repository File at Here since Theme is shared across features

import 'package:apu_assignment/core/data/shared_pref_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeRepositoryProvider = Provider((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return ThemeRepository(prefs);
});

class ThemeRepository {
  final SharedPreferences _prefs;
  static const _themeKey = "themeMode";

  ThemeRepository(this._prefs);

  ThemeMode getTheme() {
    final int? storedTheme = _prefs.getInt(_themeKey);
    switch (storedTheme) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      case 2:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveTheme(ThemeMode theme) async {
    int storedTheme;
    switch (theme) {
      case ThemeMode.light:
        storedTheme = 0;
        break;
      case ThemeMode.dark:
        storedTheme = 1;
        break;
      case ThemeMode.system:
        storedTheme = 2;
        break;
    }

    await _prefs.setInt(_themeKey, storedTheme);
  }
}
