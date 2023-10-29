import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  BuildContext? context;

  TextStyles(this.context);

  static TextStyle defaultStyle = GoogleFonts.signika(color: Colors.black);
}

extension ExtendedTextStyle on TextStyle {
  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle get small {
    return copyWith(fontSize: 12);
  }

  TextStyle get medium {
    return copyWith(fontSize: 16);
  }

  TextStyle get dailyNewsTitle {
    return copyWith(
      fontWeight: FontWeight.w900,
      fontSize: 18,
      color: Colors.black87,
    );
  }

  TextStyle get dailyNewsDetailTitle {
    return copyWith(
      fontWeight: FontWeight.w900,
      fontSize: 20,
    );
  }
}
