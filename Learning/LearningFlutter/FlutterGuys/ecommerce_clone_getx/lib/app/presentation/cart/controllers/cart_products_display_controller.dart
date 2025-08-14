import 'package:ecommerce_clone_getx/app/domain/order/entities/product_ordered_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/order/usecases/get_cart_products_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/order/usecases/remove_cart_product_usecase.dart';
import 'package:get/get.dart';

enum CartProductsDisplayState { initial, loading, success, error }

class CartProductsDisplayController extends GetxController {
  CartProductsDisplayController({
    required this.getCartProductsUseCase,
    required this.removeCartProductUseCase,
  });

  final GetCartProductsUseCase getCartProductsUseCase;
  final RemoveCartProductUseCase removeCartProductUseCase;

  var state = CartProductsDisplayState.initial.obs;
  var products = <ProductOrderedEntity>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    displayCartProducts();
  }

  void displayCartProducts() async {
    state.value = CartProductsDisplayState.loading;
    errorMessage.value = '';
    var returnedData = await getCartProductsUseCase.call();
    returnedData.fold(
      (error) {
        state.value = CartProductsDisplayState.error;
        errorMessage.value = error;
        products.clear();
      },
      (data) {
        state.value = CartProductsDisplayState.success;
        products.assignAll(data);
      },
    );
  }

  Future<void> removeProduct(ProductOrderedEntity product) async {
    state.value = CartProductsDisplayState.loading;
    errorMessage.value = '';
    var returnedData = await removeCartProductUseCase.call(params: product.id);
    returnedData.fold(
      (error) {
        state.value = CartProductsDisplayState.error;
        errorMessage.value = error;
      },
      (data) {
        state.value = CartProductsDisplayState.success;
        displayCartProducts();
      },
    );
  }
}
