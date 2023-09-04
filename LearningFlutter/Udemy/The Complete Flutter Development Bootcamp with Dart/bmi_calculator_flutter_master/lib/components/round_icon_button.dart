import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({Key? key, required this.iconData, this.onPressed})
      : super(key: key);

  final IconData iconData;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Icon(iconData),
      elevation: 0,
      constraints: BoxConstraints.tightFor(
        width: 50,
        height: 50,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4c4f5e),
    );
  }
}
