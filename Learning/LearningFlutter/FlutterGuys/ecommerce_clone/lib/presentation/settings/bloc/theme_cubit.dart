import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String _themeKey = 'theme_mode';

  ThemeCubit() : super(ThemeMode.dark) {
    _loadTheme();
  }

  void toggleTheme() {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(newTheme);
    _saveTheme(newTheme);
  }

  void setTheme(ThemeMode themeMode) {
    emit(themeMode);
    _saveTheme(themeMode);
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? ThemeMode.dark.index;
      emit(ThemeMode.values[themeIndex]);
    } catch (e) {
      emit(ThemeMode.dark); // Fallback to dark theme
    }
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, themeMode.index);
    } catch (e) {
      // Handle error silently
    }
  }
}
