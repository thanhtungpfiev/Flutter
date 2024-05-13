import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/text_styles.dart';

class HomeBottomSheetButton extends StatelessWidget {
  const HomeBottomSheetButton(
      {super.key,
      required this.label,
      this.onTap,
      required this.color,
      this.isClose = false});

  final String label;
  final Function()? onTap;
  final Color color;
  final bool isClose;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 30,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : color,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : color,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? TextStyles.defaultStyle
                : TextStyles.defaultStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
