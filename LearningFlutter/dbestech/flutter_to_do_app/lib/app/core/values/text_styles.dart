import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  BuildContext? context;
  TextStyles(this.context);

  static TextStyle defaultStyle = GoogleFonts.lato();
}

extension ExtendedTextStyle on TextStyle {
  TextStyle get bold {
    return copyWith(
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get headingStyle {
    return copyWith(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get subHeadingStyle {
    return copyWith(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
    );
  }

  TextStyle get dateTextStyle {
    return copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
    );
  }

  TextStyle get dayTextStyle {
    return dateTextStyle.copyWith(
      fontSize: 16,
    );
  }

  TextStyle get monthTextStyle {
    return dateTextStyle.copyWith(
      fontSize: 14,
    );
  }

  TextStyle get titleStyle {
    return dayTextStyle.copyWith(
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    );
  }

  TextStyle get subTitleStyle {
    return monthTextStyle.copyWith(
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
    );
  }
}
