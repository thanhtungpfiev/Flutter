import 'package:flutter/material.dart';

import '../../core/constants/dimension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../helpers/image_helper.dart';

class IntroScreenItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final AlignmentGeometry alignment;

  const IntroScreenItem(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: alignment,
          child: ImageHelper.loadFromAssets(
            image,
            height: 375,
            fit: BoxFit.fitHeight,
          ),
        ),
        const SizedBox(
          height: kMediumPadding * 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kMediumPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.defaultStyle.bold,
              ),
              const SizedBox(
                height: kMediumPadding,
              ),
              Text(
                description,
                style: TextStyles.defaultStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}
