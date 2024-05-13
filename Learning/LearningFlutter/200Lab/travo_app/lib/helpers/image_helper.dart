import 'package:flutter/widgets.dart';

class ImageHelper {
  static Widget loadFromAssets(
    String imageFilePath, {
    double? width,
    double? height,
    BorderRadius? radius,
    BoxFit? fit,
    Color? tinColor,
    Alignment? alignment,
  }) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: Image.asset(
        imageFilePath,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: tinColor,
        alignment: alignment ?? Alignment.center,
      ),
    );
  }
}
