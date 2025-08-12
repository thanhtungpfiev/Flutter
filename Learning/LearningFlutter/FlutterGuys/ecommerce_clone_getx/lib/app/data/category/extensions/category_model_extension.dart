import 'package:ecommerce_clone_getx/app/data/category/models/category_model.dart';
import 'package:ecommerce_clone_getx/app/domain/category/entities/category_entity.dart';

extension CategoryXModel on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(categoryId: categoryId, image: image, title: title);
  }
}
