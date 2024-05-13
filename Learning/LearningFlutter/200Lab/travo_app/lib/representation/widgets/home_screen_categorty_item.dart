import 'package:flutter/material.dart';

import 'package:travo_app/core/constants/dimension_constants.dart';

class HomeScreenCategoryItem extends StatelessWidget {
  final Widget icon;
  final Color color;
  final Function() onTap;
  final String title;

  const HomeScreenCategoryItem(
      {super.key,
      required this.icon,
      required this.color,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: kMediumPadding,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(kItemPadding),
            ),
            child: icon,
          ),
          const SizedBox(
            height: kItemPadding,
          ),
          Text(title),
        ],
      ),
    );
  }
}
