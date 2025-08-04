import 'package:ecommerce_clone/presentation/settings/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() async {
      // Mock SharedPreferences
      SharedPreferences.setMockInitialValues({});
      themeCubit = ThemeCubit();
    });

    tearDown(() {
      themeCubit.close();
    });

    test('initial state should be dark theme', () async {
      await Future.delayed(
        const Duration(milliseconds: 100),
      ); // Wait for _loadTheme
      expect(themeCubit.state, ThemeMode.dark);
    });

    test('toggleTheme should switch between dark and light theme', () async {
      await Future.delayed(
        const Duration(milliseconds: 100),
      ); // Wait for initial load

      // Initially dark
      expect(themeCubit.state, ThemeMode.dark);

      // Toggle to light
      themeCubit.toggleTheme();
      expect(themeCubit.state, ThemeMode.light);

      // Toggle back to dark
      themeCubit.toggleTheme();
      expect(themeCubit.state, ThemeMode.dark);
    });

    test('setTheme should set specific theme', () async {
      await Future.delayed(
        const Duration(milliseconds: 100),
      ); // Wait for initial load

      themeCubit.setTheme(ThemeMode.light);
      expect(themeCubit.state, ThemeMode.light);

      themeCubit.setTheme(ThemeMode.dark);
      expect(themeCubit.state, ThemeMode.dark);
    });
  });
}
