import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  const BasicAppButton({
    required this.onPressed,
    this.title = '',
    this.height,
    this.width,
    this.content,
    super.key,
  });

  final VoidCallback onPressed;
  final String title;
  final Widget? content;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? ResponsiveUtils.screenWidth,
          height ?? ResponsiveUtils.height(50),
        ),
      ),
      child:
          content ??
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: ResponsiveUtils.fontSize(16),
            ),
          ),
    );
  }
}
