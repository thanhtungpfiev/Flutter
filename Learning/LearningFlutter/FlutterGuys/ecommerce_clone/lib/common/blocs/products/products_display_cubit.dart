import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'products_display_state.dart';

class ProductsDisplayCubit extends Cubit<ProductsDisplayState> {
  ProductsDisplayCubit({required this.useCase})
    : super(ProductsDisplayInitialState());

  final UseCase useCase;

  void displayProducts({dynamic params}) async {
    emit(ProductsDisplayLoadingState());
    var returnedData = await useCase.call(params: params);
    returnedData.fold(
      (error) {
        emit(LoadProductsLoadErrorState());
      },
      (data) {
        emit(ProductsDisplayLoadSuccessfulState(products: data));
      },
    );
  }

  void displayInitial() {
    emit(ProductsDisplayInitialState());
  }
}
