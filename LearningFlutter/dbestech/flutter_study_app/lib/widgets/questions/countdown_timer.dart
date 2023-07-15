import 'package:flutter/material.dart';

import '../../configs/themes/custom_text_styles.dart';

class CountdownTimer extends StatelessWidget {
  final Color? color;
  final String time;

  const CountdownTimer({super.key, this.color, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color ?? Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          time,
          style: countDownTimerTs().copyWith(color: color),
        ),
      ],
    );
  }
}
