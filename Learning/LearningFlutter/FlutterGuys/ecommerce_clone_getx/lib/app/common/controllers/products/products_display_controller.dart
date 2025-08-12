import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:get/get.dart';

enum ProductDisplayState { initial, loading, success, error }

class ProductsDisplayController extends GetxController {
  ProductsDisplayController({required this.useCase});

  final UseCase useCase;

  var state = ProductDisplayState.initial.obs;
  var products = <ProductEntity>[].obs;

  Future<void> displayProducts({dynamic params}) async {
    state.value = ProductDisplayState.loading;
    var returnedData = await useCase.call(params: params);
    returnedData.fold(
      (error) {
        state.value = ProductDisplayState.error;
      },
      (data) {
        state.value = ProductDisplayState.success;
        products.value = data;
      },
    );
  }

  void displayInitial() {
    state.value = ProductDisplayState.initial;
  }
}
