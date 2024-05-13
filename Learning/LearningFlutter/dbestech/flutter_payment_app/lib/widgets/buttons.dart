import 'package:flutter/material.dart';

import '../component/colors.dart';

class AppButtons extends StatelessWidget {
  const AppButtons({
    super.key,
    this.fontSize = 20,
    required this.icon,
    this.onTap,
    this.backgroundColor = AppColor.mainColor,
    this.iconColor = Colors.white,
    this.textColor = AppColor.mainColor,
    this.text,
  });

  final double? fontSize;
  final IconData icon;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor,
            ),
            child: Icon(
              icon,
              size: 30,
              color: iconColor,
            ),
          ),
          text != null
              ? Text(
                  text!,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
