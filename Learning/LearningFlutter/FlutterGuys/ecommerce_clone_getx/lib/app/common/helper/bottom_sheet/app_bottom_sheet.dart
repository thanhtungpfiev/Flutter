import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class AppBottomSheet {
  static Future<void> display(BuildContext context, Widget widget) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(ResponsiveUtils.radius(25)),
          topLeft: Radius.circular(ResponsiveUtils.radius(25)),
        ),
      ),
      builder: (_) {
        return widget;
      },
    );
  }
}
