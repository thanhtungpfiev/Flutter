// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_clone_getx/app/core/constants/product_constants.dart';

class ProductColorModel {
  final String title;
  final List<int> rgb;

  ProductColorModel({required this.title, required this.rgb});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ProductConstants.title: title,
      ProductConstants.rgb: rgb,
    };
  }

  factory ProductColorModel.fromMap(Map<String, dynamic> map) {
    return ProductColorModel(
      title: map[ProductConstants.title] as String,
      rgb: List<int>.from(map[ProductConstants.rgb].map((e) => e)),
    );
  }
}
