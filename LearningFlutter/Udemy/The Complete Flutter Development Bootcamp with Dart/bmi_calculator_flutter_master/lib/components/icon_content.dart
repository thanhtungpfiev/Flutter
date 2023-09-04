import 'package:flutter/material.dart';

import '../constants.dart';

class IconContent extends StatelessWidget {
  const IconContent({
    Key? key,
    required this.iconData,
    required this.textContent,
  }) : super(key: key);

  final IconData iconData;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 60,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          textContent,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
