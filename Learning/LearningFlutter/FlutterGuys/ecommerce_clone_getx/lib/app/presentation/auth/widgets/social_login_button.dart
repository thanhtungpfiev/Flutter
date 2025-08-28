import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          ResponsiveUtils.screenWidth,
          ResponsiveUtils.height(50),
        ),
        backgroundColor:
            backgroundColor ?? ThemeHelper.getSecondBackground(context),
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      child: Stack(
        children: [
          Positioned(
            left: ResponsiveUtils.width(16),
            top: 0,
            bottom: 0,
            child: Center(
              child: SizedBox(
                width: ResponsiveUtils.fontSize(24),
                height: ResponsiveUtils.fontSize(24),
                child: icon,
              ),
            ),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(16),
                fontWeight: FontWeight.w400,
                color: textColor ?? ThemeHelper.getTextColor(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
