import 'package:flutter/material.dart';

import 'theme_color.dart';

class ThemeApp {
  static final light = ThemeData.light().copyWith(
    primaryColor: ThemeColor.primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColor.whiteColor,
      iconTheme: IconThemeData(
        color: ThemeColor.blackColor,
        size: 20,
      ),
      titleTextStyle: TextStyle(
        color: ThemeColor.blackColor,
      ),
    ),
    brightness: Brightness.light,
  );
  static final dark = ThemeData.dark().copyWith(
    primaryColor: ThemeColor.darkGreyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColor.darkGreyColor,
      iconTheme: IconThemeData(
        color: ThemeColor.whiteColor,
        size: 20,
      ),
      titleTextStyle: TextStyle(
        color: ThemeColor.whiteColor,
      ),
    ),
    brightness: Brightness.dark,
  );
}
