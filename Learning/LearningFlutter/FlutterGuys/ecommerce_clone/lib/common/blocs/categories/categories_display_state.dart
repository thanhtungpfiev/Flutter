import 'package:ecommerce_clone/domain/category/entities/category_entity.dart';

abstract class CategoriesDisplayState {}

class CategoriesDisplayLoadingState extends CategoriesDisplayState {}

class CategoriesDisplayLoadSuccessState extends CategoriesDisplayState {
  final List<CategoryEntity> categories;
  CategoriesDisplayLoadSuccessState({required this.categories});
}

class CategoriesDisplayLoadErrorState extends CategoriesDisplayState {}
