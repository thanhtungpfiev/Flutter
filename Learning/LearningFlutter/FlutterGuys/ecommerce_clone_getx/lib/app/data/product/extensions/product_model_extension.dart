import 'package:ecommerce_clone_getx/app/data/product/extensions/product_color_extension.dart';
import 'package:ecommerce_clone_getx/app/data/product/models/product_model.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';

extension ProductXModel on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
      categoryId: categoryId,
      colors: colors.map((e) => e.toEntity()).toList(),
      createdDate: createdDate,
      discountedPrice: discountedPrice,
      gender: gender,
      images: images,
      price: price,
      sizes: sizes,
      productId: productId,
      salesNumber: salesNumber,
      title: title,
    );
  }
}

extension ProductXEntity on ProductEntity {
  ProductModel fromEntity() {
    return ProductModel(
      categoryId: categoryId,
      colors: colors.map((e) => e.fromEntity()).toList(),
      createdDate: createdDate,
      discountedPrice: discountedPrice,
      gender: gender,
      images: images,
      price: price,
      sizes: sizes,
      productId: productId,
      salesNumber: salesNumber,
      title: title,
    );
  }
}
