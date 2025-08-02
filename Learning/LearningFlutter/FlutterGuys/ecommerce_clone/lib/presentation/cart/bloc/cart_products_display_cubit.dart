import 'package:ecommerce_clone/domain/order/entities/product_ordered_entity.dart';
import 'package:ecommerce_clone/domain/order/usecases/get_cart_products_usecase.dart';
import 'package:ecommerce_clone/domain/order/usecases/remove_cart_product_usecase.dart';
import 'package:ecommerce_clone/presentation/cart/bloc/cart_products_display_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit({
    required this.getCartProductsUseCase,
    required this.removeCartProductUseCase,
  }) : super(CartProductsDisplayLoadingState());

  final GetCartProductsUseCase getCartProductsUseCase;
  final RemoveCartProductUseCase removeCartProductUseCase;

  void displayCartProducts() async {
    var returnedData = await getCartProductsUseCase.call();

    returnedData.fold(
      (error) {
        emit(LoadCartProductsDisplayLoadErrorState(errorMessage: error));
      },
      (data) {
        emit(CartProductsDisplayLoadSuccessState(products: data));
      },
    );
  }

  Future<void> removeProduct(ProductOrderedEntity product) async {
    emit(CartProductsDisplayLoadingState());
    var returnedData = await removeCartProductUseCase.call(params: product.id);

    returnedData.fold(
      (error) {
        emit(LoadCartProductsDisplayLoadErrorState(errorMessage: error));
      },
      (data) {
        displayCartProducts();
      },
    );
  }
}
