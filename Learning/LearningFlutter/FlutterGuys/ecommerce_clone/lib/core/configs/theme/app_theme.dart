import 'package:flutter/material.dart';

import '../../utils/responsive_utils.dart';
import 'app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.dark,
    fontFamily: 'CircularStd',
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.background,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.secondBackground,
      hintStyle: const TextStyle(
        color: Color(0xffA7A7A7),
        fontWeight: FontWeight.w400,
      ),
      contentPadding: EdgeInsets.all(ResponsiveUtils.width(16)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(4)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(4)),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        textStyle: TextStyle(
          fontSize: ResponsiveUtils.fontSize(16),
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveUtils.radius(100)),
        ),
      ),
    ),
  );
}
