import 'package:ecommerce_clone_getx/app/presentation/splash/controllers/splash_controller.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(isLoggedInUseCase: sl()));
  }
}
