import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/values/text_styles.dart';
import '../../../global_widgets/my_button.dart';
import '../../../routes/app_pages.dart';

class HomeAddTaskBar extends StatelessWidget {
  const HomeAddTaskBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: TextStyles.defaultStyle.subHeadingStyle,
              ),
              Text(
                'Today',
                style: TextStyles.defaultStyle.headingStyle,
              )
            ],
          ),
          MyButton(
            label: '+ Add Task',
            onTap: () => Get.toNamed(Routes.addTask),
          ),
        ],
      ),
    );
  }
}
