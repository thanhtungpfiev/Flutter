// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_clone_getx/app/common/enums/gender.dart';
import 'package:ecommerce_clone_getx/app/core/constants/product_constants.dart';
import 'package:ecommerce_clone_getx/app/data/product/models/product_color_model.dart';

class ProductModel {
  final String categoryId;
  final List<ProductColorModel> colors;
  final Timestamp createdDate;
  final num discountedPrice;
  final Gender gender;
  final List<String> images;
  final num price;
  final List<String> sizes;
  final String productId;
  final int salesNumber;
  final String title;

  ProductModel({
    required this.categoryId,
    required this.colors,
    required this.createdDate,
    required this.discountedPrice,
    required this.gender,
    required this.images,
    required this.price,
    required this.sizes,
    required this.productId,
    required this.salesNumber,
    required this.title,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      categoryId: map[ProductConstants.categoryId] as String,
      colors: List<ProductColorModel>.from(
        map[ProductConstants.colors].map((e) => ProductColorModel.fromMap(e)),
      ),
      createdDate: map[ProductConstants.createdDate] as Timestamp,
      discountedPrice: map[ProductConstants.discountedPrice] as num,
      gender: map[ProductConstants.gender] is int
          ? Gender.fromInt(map[ProductConstants.gender] as int)
          : Gender.fromFirestore(map[ProductConstants.gender].toString()),
      images: List<String>.from(
        map[ProductConstants.images].map((e) => e.toString()),
      ),
      price: map[ProductConstants.price] as num,
      sizes: List<String>.from(
        map[ProductConstants.sizes].map((e) => e.toString()),
      ),
      productId: map[ProductConstants.productId] as String,
      salesNumber: map[ProductConstants.salesNumber] as int,
      title: map[ProductConstants.title] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ProductConstants.categoryId: categoryId,
      ProductConstants.colors: colors.map((e) => e.toMap()).toList(),
      ProductConstants.createdDate: createdDate,
      ProductConstants.discountedPrice: discountedPrice,
      ProductConstants.gender: gender.toInt(),
      ProductConstants.images: images.map((e) => e.toString()).toList(),
      ProductConstants.price: price,
      ProductConstants.sizes: sizes.map((e) => e.toString()).toList(),
      ProductConstants.productId: productId,
      ProductConstants.salesNumber: salesNumber,
      ProductConstants.title: title,
    };
  }
}
