import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _border([Color color = AppColors.borderColor]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
        borderSide: BorderSide(color: color, width: ResponsiveUtils.width(3)),
      );
  static ThemeData get darkThemeMode => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      centerTitle: true,
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(AppColors.backgroundColor),
      side: BorderSide.none,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.backgroundColor,
      contentTextStyle: TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(ResponsiveUtils.width(27)),
      enabledBorder: _border(),
      focusedBorder: _border(AppColors.gradient2),
      errorBorder: _border(AppColors.errorColor),
      focusedErrorBorder: _border(AppColors.errorColor),
    ),
  );
}
