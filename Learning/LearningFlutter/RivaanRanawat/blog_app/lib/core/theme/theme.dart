import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _border([Color color = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
        borderSide: BorderSide(color: color, width: ResponsiveUtils.width(3)),
      );
  static ThemeData get darkThemeMode => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(ResponsiveUtils.width(27)),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );
}
