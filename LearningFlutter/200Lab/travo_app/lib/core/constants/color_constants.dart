import 'package:flutter/material.dart';

class ColorPalette {
  static const Color primaryColor = Color(0xff6155CC);
  static const Color secondaryColor = Color(0xff8F67E8);
  static const Color yellowColor = Color(0xffFE9C5E);

  static const Color dividerColor = Color(0xffE5E7EB);
  static const Color titleColor = Color(0xff323B4B);
  static const Color subTitleColor = Color(0xff838383);
  static const Color backgroundScaffoldColor = Color(0xffF2F2F2);
}

class Gradients {
  static const LinearGradient defaultBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorPalette.secondaryColor,
      ColorPalette.primaryColor,
    ],
  );
}
