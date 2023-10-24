import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.white,
      primaryColor: Colors.black,
      splashColor: Colors.transparent,
      fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
      useMaterial3: true,
    );
  }
}
