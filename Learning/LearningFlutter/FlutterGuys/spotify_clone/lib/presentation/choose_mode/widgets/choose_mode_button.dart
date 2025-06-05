import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseModeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String assetName;

  const ChooseModeButton({
    super.key,
    required this.onTap,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xff30393C).withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(assetName, fit: BoxFit.none),
          ),
        ),
      ),
    );
  }
}
