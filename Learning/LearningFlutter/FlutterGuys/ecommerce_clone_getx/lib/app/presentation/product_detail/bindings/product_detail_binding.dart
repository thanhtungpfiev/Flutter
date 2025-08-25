import 'package:ecommerce_clone_getx/app/domain/product/usecases/add_or_remove_favorite_product_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/usecases/is_favorite_usecase.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/favorite_icon_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_color_selection_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_quantity_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_size_selection_controller.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
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
    Get.lazyPut<FavoriteIconController>(
      () => FavoriteIconController(
        isFavoriteUseCase: sl<IsFavoriteUseCase>(),
        addOrRemoveFavoriteProductUseCase:
            sl<AddOrRemoveFavoriteProductUseCase>(),
      ),
    );
  }
}
