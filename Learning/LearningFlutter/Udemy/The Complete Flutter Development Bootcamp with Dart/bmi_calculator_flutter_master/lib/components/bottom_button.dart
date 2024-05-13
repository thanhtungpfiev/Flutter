import 'package:flutter/material.dart';

import '../constants.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({
    Key? key,
    this.onTap,
    required this.textContent,
  }) : super(key: key);

  final void Function()? onTap;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kBottomContainerColor,
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: kBottomContainerHeight,
        child: Center(
          child: Text(
            textContent,
            style: kLargeButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
