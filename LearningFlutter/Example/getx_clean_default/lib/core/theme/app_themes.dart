import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../configs/constants/color_constants.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: GoogleFonts.mulish().fontFamily,
      appBarTheme: appBarTheme());
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(defaultColor)),
    titleTextStyle: TextStyle(color: Color(defaultColor), fontSize: 18),
  );
}
