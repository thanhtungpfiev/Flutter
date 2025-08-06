import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/core/utils/app_logger.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/is_logged_in_usecase.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final IsLoggedInUseCase isLoggedInUseCase;

  SplashController({required this.isLoggedInUseCase});

  @override
  void onInit() {
    super.onInit();
    appStarted();
  }

  void appStarted() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      var isLoggedIn = await isLoggedInUseCase.call();
      if (isLoggedIn) {
        Get.offNamed(Routes.home);
      } else {
        Get.offNamed(Routes.signin);
      }
    } catch (e) {
      AppLogger.e('Error in appStarted: $e');
    }
  }
}
