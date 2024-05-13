import 'package:flutter/material.dart';
import 'package:travo_app/core/constants/color_constants.dart';
import 'package:travo_app/core/constants/dimension_constants.dart';

import '../../core/constants/textstyle_constants.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const ButtonWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMediumPadding),
          gradient: Gradients.defaultBackgroundGradient,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: kItemPadding),
        child: Text(
          title,
          style: TextStyles.defaultStyle.bold.whiteTextColor,
        ),
      ),
    );
  }
}
