import 'package:flutter/material.dart';

import '../../../core/theme/theme_color.dart';
import '../../../core/values/text_styles.dart';
import '../../../data/models/task.dart';

class HomeTaskTile extends StatelessWidget {
  final Task? task;

  const HomeTaskTile({super.key, this.task});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title ?? "",
                  style: TextStyles.defaultStyle.bold.dayTextStyle
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${task!.startTime} - ${task!.endTime}",
                      style: TextStyles.defaultStyle
                          .copyWith(fontSize: 13, color: Colors.grey[100]),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  task?.note ?? "",
                  style: TextStyles.defaultStyle
                      .copyWith(fontSize: 15, color: Colors.grey[100]),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted == 1 ? "COMPLETED" : "TODO",
              style: TextStyles.defaultStyle.bold
                  .copyWith(fontSize: 10, color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return ThemeColor.bluishColor;
      case 1:
        return ThemeColor.pinkColor;
      case 2:
        return ThemeColor.yellowColor;
      default:
        return ThemeColor.bluishColor;
    }
  }
}
