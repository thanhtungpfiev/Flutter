import 'package:ecommerce_clone_getx/app/common/controllers/categories/categories_display_controller.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/get_user_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/category/usecases/get_categories_usecase.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/controllers/user_info_display_controller.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserInfoDisplayController>(
      UserInfoDisplayController(getUserUseCase: sl<GetUserUseCase>()),
    );
    Get.put<CategoriesDisplayController>(
      CategoriesDisplayController(
        getCategoriesUseCase: sl<GetCategoriesUseCase>(),
      ),
    );
  }
}
