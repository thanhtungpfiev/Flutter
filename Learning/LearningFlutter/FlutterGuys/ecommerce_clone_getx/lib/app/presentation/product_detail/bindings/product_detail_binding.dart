import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_color_selection_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_quantity_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_size_selection_controller.dart';
import 'package:get/get.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductSizeSelectionController>(
      () => ProductSizeSelectionController(),
    );
    Get.lazyPut<ProductColorSelectionController>(
      () => ProductColorSelectionController(),
    );
    Get.lazyPut<ProductQuantityController>(() => ProductQuantityController());
  }
}
