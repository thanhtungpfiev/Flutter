import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;

  const AuthGradientButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppPallete.gradient1, AppPallete.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(7)),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
            ResponsiveUtils.width(395),
            ResponsiveUtils.height(55),
          ),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
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
