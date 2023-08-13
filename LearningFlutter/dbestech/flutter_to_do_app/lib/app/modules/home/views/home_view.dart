import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/helpers/theme_helper.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final themeHelper = Get.put(ThemeHelper());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            themeHelper.changeThemeMode();
            // controller.localNotificationHelper.displayNotification(
            //   title: 'Theme Changed',
            //   body: Get.isDarkMode
            //       ? 'Activated Light Theme'
            //       : 'Activated Dark Theme',
            // );
            // controller.localNotificationHelper.scheduledNotification();
            // controller.localNotificationHelper.listenNotification();
          },
          child: Obx(() {
            return Icon(
              themeHelper.isDarkMode.value
                  ? Icons.wb_sunny_outlined
                  : Icons.nightlight_round,
            );
          }),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/Me_avatar.jpg'),
          )
        ],
      ),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
