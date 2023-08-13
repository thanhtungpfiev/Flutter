import 'package:get/get.dart';

import '../../../core/utils/helpers/local_notification_helper.dart';

class HomeController extends GetxController {
  final localNotificationHelper = LocalNotificationHelper();

  @override
  void onInit() {
    super.onInit();
    localNotificationHelper.initializeNotification();
    localNotificationHelper.requestAndroidPermissions();
  }
}
