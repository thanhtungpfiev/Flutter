import 'package:ecommerce_clone_getx/app/common/helper/theme/is_dark_mode.dart';
import 'package:ecommerce_clone_getx/app/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeHelper {
  /// Returns true if the current theme is dark mode (uses existing extension)
  static bool isDark(BuildContext context) {
    return context.isDarkMode;
  }

  /// Returns the appropriate color based on theme
  static Color getThemedColor(
    BuildContext context, {
    required Color lightColor,
    required Color darkColor,
  }) {
    return context.isDarkMode ? darkColor : lightColor;
  }

  /// Returns black for light theme, white for dark theme
  static Color getIconColor(BuildContext context) {
    return context.isDarkMode ? Colors.white : Colors.black;
  }

  /// Returns white for light theme, black for dark theme (inverse of icon color)
  static Color getInverseIconColor(BuildContext context) {
    return context.isDarkMode ? Colors.black : Colors.white;
  }

  /// Returns the appropriate second background color (uses AppColors method)
  static Color getSecondBackground(BuildContext context) {
    return context.isDarkMode
        ? AppColors.secondBackground
        : AppColors.lightSecondBackground;
  }

  /// Returns the current theme's icon color
  static Color? getThemeIconColor(BuildContext context) {
    return Theme.of(context).iconTheme.color;
  }

  /// Returns black for light theme, white for dark theme (for text)
  static Color getTextColor(BuildContext context) {
    return context.isDarkMode ? Colors.white : Colors.black;
  }
}
