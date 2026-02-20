import 'package:apu_assignment/core/theme/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeViewModelProvider = NotifierProvider<ThemeViewModel, ThemeMode>(() {
  return ThemeViewModel();
});

class ThemeViewModel extends Notifier<ThemeMode> {
  late final ThemeRepository _repository;
  
  @override
  ThemeMode build() {
    _repository = ref.watch(themeRepositoryProvider);

    return _repository.getTheme();
  }

  void changeTheme(ThemeMode theme) {
    state = theme;
    _repository.saveTheme(theme);
  }
}

