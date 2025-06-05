import 'package:flutter/material.dart';
import 'package:spotify_clone/core/configs/theme/app_colors.dart';
import 'package:spotify_clone/presentation/choose_mode/widgets/choose_mode_button.dart';

class ChooseModeItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String assetName;

  const ChooseModeItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChooseModeButton(onTap: onTap, assetName: assetName),
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
