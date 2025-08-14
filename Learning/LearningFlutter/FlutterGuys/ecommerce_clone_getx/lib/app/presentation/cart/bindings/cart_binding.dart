import 'package:ecommerce_clone_getx/app/domain/order/usecases/get_cart_products_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/order/usecases/remove_cart_product_usecase.dart';
import 'package:ecommerce_clone_getx/app/presentation/cart/controllers/cart_products_display_controller.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartProductsDisplayController>(
      () => CartProductsDisplayController(
        getCartProductsUseCase: sl<GetCartProductsUseCase>(),
        removeCartProductUseCase: sl<RemoveCartProductUseCase>(),
      ),
    );
  }
}
