import 'package:ecommerce_clone/data/product/models/product_color_model.dart';
import 'package:ecommerce_clone/domain/product/entities/product_color_entity.dart';

extension ProductColorXModel on ProductColorModel {
  ProductColorEntity toEntity() {
    return ProductColorEntity(title: title, rgb: rgb);
  }
}

extension ProductColorXEntity on ProductColorEntity {
  ProductColorModel fromEntity() {
    return ProductColorModel(title: title, rgb: rgb);
  }
}
