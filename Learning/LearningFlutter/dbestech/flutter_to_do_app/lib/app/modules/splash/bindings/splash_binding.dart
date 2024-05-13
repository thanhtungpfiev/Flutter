import 'package:get/get.dart';

import '../../../data/repositories/task_repository.dart';
import '../../../routes/app_pages.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
    initAllServices();
  }

  void initAllServices() async {
    Get.put(TaskRepository());
    await Future.delayed(const Duration(seconds: 2));
    Get.toNamed(Routes.home);
  }
}
