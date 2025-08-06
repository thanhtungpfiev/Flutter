import 'package:ecommerce_clone_getx/app/presentation/auth/controllers/age_selection_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/controllers/ages_display_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/controllers/gender_selection_controller.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GenderSelectionController>(GenderSelectionController());
    Get.put<AgesDisplayController>(AgesDisplayController(getAgesUseCase: sl()));
    Get.put<AgeSelectionController>(AgeSelectionController());
  }
}
