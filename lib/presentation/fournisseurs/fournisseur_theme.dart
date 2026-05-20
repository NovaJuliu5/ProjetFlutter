import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:help_neighbor/app/dependances.dart';

final themeModeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = getIt<SharedPreferences>();
    final themeString = prefs.getString('theme_mode');
    if (themeString != null) {
      state = ThemeMode.values.firstWhere((e) => e.toString() == themeString);
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    final prefs = getIt<SharedPreferences>();
    await prefs.setString('theme_mode', mode.toString());
  }
}