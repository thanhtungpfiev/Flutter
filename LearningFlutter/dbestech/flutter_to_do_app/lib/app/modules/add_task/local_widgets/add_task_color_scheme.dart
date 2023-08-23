import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme_color.dart';
import '../../../core/values/text_styles.dart';
import '../controllers/add_task_controller.dart';

class AddTaskColorScheme extends StatelessWidget {
  AddTaskColorScheme({
    super.key,
  });

  final AddTaskController controller = Get.find<AddTaskController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TextStyles.defaultStyle.titleStyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                controller.colorSelected.value = index;
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Obx(() {
                  return CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? ThemeColor.primaryColor
                        : index == 1
                            ? ThemeColor.pinkColor
                            : ThemeColor.yellowColor,
                    child: controller.colorSelected.value == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  );
                }),
              ),
            );
          }),
        )
      ],
    );
  }
}
