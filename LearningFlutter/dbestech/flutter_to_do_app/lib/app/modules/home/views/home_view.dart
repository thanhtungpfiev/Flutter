import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers/theme_helper.dart';
import '../../../global_widgets/my_custom_appbar.dart';
import '../controllers/home_controller.dart';
import '../local_widgets/home_add_date_bar.dart';
import '../local_widgets/home_add_task_bar.dart';
import '../local_widgets/home_tasks_listview.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final themeHelper = Get.put(ThemeHelper());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        onTap: () {
          themeHelper.changeThemeMode();
          controller.getAllTasks();
        },
        child: Obx(() {
          return Icon(
            themeHelper.isDarkMode.value
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round,
          );
        }),
      ),
      body: Column(
        children: [
          const HomeAddTaskBar(),
          HomeAddDateBar(),
          const SizedBox(
            height: 5,
          ),
          HomeTasksListView(),
        ],
      ),
    );
  }
}
