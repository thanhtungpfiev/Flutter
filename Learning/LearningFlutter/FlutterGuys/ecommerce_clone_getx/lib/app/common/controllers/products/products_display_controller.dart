import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:get/get.dart';

enum ProductDisplayState { initial, loading, success, error }

class ProductsDisplayController extends GetxController {
  ProductsDisplayController({required this.useCase});

  final UseCase useCase;

  final state = ProductDisplayState.initial.obs;
  final products = <ProductEntity>[].obs;
  final errorMessage = ''.obs;

  Future<void> displayProducts({dynamic params}) async {
    state.value = ProductDisplayState.loading;
    errorMessage.value = '';
    var returnedData = await useCase.call(params: params);
    returnedData.fold(
      (error) {
        state.value = ProductDisplayState.error;
        errorMessage.value = error;
        products.clear();
      },
      (data) {
        state.value = ProductDisplayState.success;
        errorMessage.value = '';
        products.assignAll(data);
      },
    );
  }

  void displayInitial() {
    state.value = ProductDisplayState.initial;
  }
}
