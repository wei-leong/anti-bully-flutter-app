import 'package:apu_assignment/core/data/shared_pref_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  // Used 33 the ThemeMode.light since Light means Clair in French
  static const _themeKey = "themeMode";
  
  @override
  ThemeMode build() {
    final prefs = ref.read(sharedPrefsProvider);
    final int? storedTheme = prefs.getInt(_themeKey);
    ThemeMode getThemeMode;

    if (storedTheme != null) {
      switch (storedTheme) {
        case 0:
          getThemeMode = ThemeMode.light;
        case 1:
          getThemeMode = ThemeMode.dark;
        case 2:
        default:
          getThemeMode = ThemeMode.system;
          break;
      }
    }else{
      getThemeMode = ThemeMode.system;
    }

    return getThemeMode;
  }

  void changeTheme(ThemeMode theme) {
    final prefs = ref.read(sharedPrefsProvider);
    int storedTheme;
    state = theme;
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

    prefs.setInt(_themeKey, storedTheme);
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});
