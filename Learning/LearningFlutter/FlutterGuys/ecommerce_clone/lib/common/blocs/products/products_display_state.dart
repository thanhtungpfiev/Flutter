import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';

abstract class ProductsDisplayState {}

class ProductsDisplayInitialState extends ProductsDisplayState {}

class ProductsDisplayLoadingState extends ProductsDisplayState {}

class ProductsDisplayLoadSuccessfulState extends ProductsDisplayState {
  final List<ProductEntity> products;
  ProductsDisplayLoadSuccessfulState({required this.products});
}

class LoadProductsLoadErrorState extends ProductsDisplayState {}
