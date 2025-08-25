import 'package:ecommerce_clone_getx/app/common/controllers/products/products_display_controller.dart';
import 'package:ecommerce_clone_getx/app/core/constants/service_constants.dart';
import 'package:ecommerce_clone_getx/app/domain/order/usecases/get_orders_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/usecases/get_favorites_products_usecase.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/controllers/orders_display_controller.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:get/get.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsDisplayController>(
      () =>
          ProductsDisplayController(useCase: sl<GetFavoritesProductsUseCase>()),
      tag: ServiceConstants.getFavoritesProductsUseCaseInstance,
    );
    Get.lazyPut<OrdersDisplayController>(
      () => OrdersDisplayController(getOrdersUseCase: sl<GetOrdersUseCase>()),
    );
  }
}
