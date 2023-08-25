import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/task.dart';
import '../controllers/home_controller.dart';
import 'home_bottom_sheet.dart';
import 'home_task_tile.dart';

class HomeTasksListView extends StatelessWidget {
  HomeTasksListView({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: controller.taskRepository.allTasks.length,
          itemBuilder: (_, index) {
            Task task = controller.taskRepository.allTasks[index];
            if (task.repeat == 'Daily' ||
                task.date ==
                    DateFormat.yMd().format(controller.selectedDate.value)) {
              var hour = task.startTime!.split(':')[0];
              var minute = task.startTime!.split(':')[1].split(' ')[0];
              var am = task.startTime!.split(':')[1].split(' ')[1];
              controller.localNotificationHelper.scheduledNotification(
                  am == 'AM' ? int.parse(hour) : int.parse(hour) + 12,
                  int.parse(minute),
                  task);
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              HomeBottomSheet(task: task),
                            );
                          },
                          child: HomeTaskTile(task: task),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }
}
