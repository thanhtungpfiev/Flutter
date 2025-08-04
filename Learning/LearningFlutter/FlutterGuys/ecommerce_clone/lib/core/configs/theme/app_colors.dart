import 'package:flutter/material.dart';

class AppColors {
  // Dark theme colors
  static const primary = Color(0xff8E6CEF);
  static const background = Color(0xff1D182A);
  static const secondBackground = Color(0xff342F3F);

  // Light theme colors
  static const lightBackground = Color(0xffFFFFFF);
  static const lightSecondBackground = Color(0xffF4F4F4);
}

@immutable
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  final Color secondBackground;

  const AppColorExtension({required this.secondBackground});

  @override
  AppColorExtension copyWith({Color? secondBackground}) {
    return AppColorExtension(
      secondBackground: secondBackground ?? this.secondBackground,
    );
  }

  @override
  AppColorExtension lerp(ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) {
      return this;
    }
    return AppColorExtension(
      secondBackground:
          Color.lerp(secondBackground, other.secondBackground, t)!,
    );
  }

  static const light = AppColorExtension(
    secondBackground: AppColors.lightSecondBackground,
  );

  static const dark = AppColorExtension(
    secondBackground: AppColors.secondBackground,
  );
}
