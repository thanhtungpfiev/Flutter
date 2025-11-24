import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.gradient1, AppColors.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(7)),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            ResponsiveUtils.width(395),
            ResponsiveUtils.height(55),
          ),
          backgroundColor: AppColors.transparentColor,
          shadowColor: AppColors.transparentColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: ResponsiveUtils.fontSize(17),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
