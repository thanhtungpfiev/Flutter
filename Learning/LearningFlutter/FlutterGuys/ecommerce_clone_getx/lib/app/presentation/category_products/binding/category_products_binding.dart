import 'package:ecommerce_clone_getx/app/common/controllers/products/products_display_controller.dart';
import 'package:ecommerce_clone_getx/app/core/constants/service_constants.dart';
import 'package:ecommerce_clone_getx/app/domain/product/usecases/get_products_by_category_id_usecase.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:get/get.dart';

class CategoryProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductsDisplayController>(
      ProductsDisplayController(useCase: sl<GetProductsByCategoryIdUseCase>()),
      tag: ServiceConstants.getProductsByCategoryIdUseCaseInstance,
    );
  }
}
