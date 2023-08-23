import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme_color.dart';
import '../../../data/models/task.dart';
import '../controllers/home_controller.dart';
import 'home_bottom_sheeet_button.dart';

class HomeBottomSheet extends StatelessWidget {
  HomeBottomSheet({
    super.key,
    required this.task,
  });

  final Task task;
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? ThemeColor.darkGreyColor : Colors.white,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
            ),
          ),
          const Spacer(),
          if (task.isCompleted != 1)
            HomeBottomSheetButton(
              label: 'Task Completed',
              color: ThemeColor.primaryColor,
              onTap: () {
                Task newTask = task.copyWith(isCompleted: 1);
                controller.updateTask(task, newTask);
                Get.back();
              },
            ),
          HomeBottomSheetButton(
            label: 'Delete Task',
            color: Colors.red[300]!,
            onTap: () {
              controller.deleteTask(task);
              Get.back();
            },
          ),
          const SizedBox(
            height: 20,
          ),
          HomeBottomSheetButton(
            label: 'Close',
            color: Colors.red[300]!,
            onTap: () => Get.back(),
            isClose: true,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
