import 'package:ecommerce_clone/domain/order/entities/product_ordered_entity.dart';

abstract class CartProductsDisplayState {}

class CartProductsDisplayLoadingState extends CartProductsDisplayState {}

class CartProductsDisplayLoadSuccessState extends CartProductsDisplayState {
  final List<ProductOrderedEntity> products;
  CartProductsDisplayLoadSuccessState({required this.products});
}

class LoadCartProductsDisplayLoadErrorState extends CartProductsDisplayState {
  final String errorMessage;

  LoadCartProductsDisplayLoadErrorState({required this.errorMessage});
}
