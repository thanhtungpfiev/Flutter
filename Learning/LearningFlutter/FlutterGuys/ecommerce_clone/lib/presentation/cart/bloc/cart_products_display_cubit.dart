import 'package:ecommerce_clone/domain/order/usecases/get_cart_products_usecase.dart';
import 'package:ecommerce_clone/presentation/cart/bloc/cart_products_display_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductsDisplayCubit extends Cubit<CartProductsDisplayState> {
  CartProductsDisplayCubit({required this.getCartProductsUseCase})
    : super(CartProductsDisplayLoadingState());

  final GetCartProductsUseCase getCartProductsUseCase;

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

  // Future<void> removeProduct(ProductOrderedEntity product) async {
  //   emit(CartProductsDisplayLoadingState());
  //   var returnedData = await sl<RemoveCartProductUseCase>().call(
  //     params: product.id,
  //   );

  //   returnedData.fold(
  //     (error) {
  //       emit(LoadCartProductsDisplayLoadErrorState(errorMessage: error));
  //     },
  //     (data) {
  //       displayCartProducts();
  //     },
  //   );
  // }
}
