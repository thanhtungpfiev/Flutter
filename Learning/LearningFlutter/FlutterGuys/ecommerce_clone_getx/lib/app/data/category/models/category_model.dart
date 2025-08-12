// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce_clone_getx/app/core/constants/category_constants.dart';

class CategoryModel {
  final String title;
  final String categoryId;
  final String image;

  CategoryModel({
    required this.title,
    required this.categoryId,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CategoryConstants.title: title,
      CategoryConstants.categoryId: categoryId,
      CategoryConstants.image: image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      title: map[CategoryConstants.title] as String,
      categoryId: map[CategoryConstants.categoryId] as String,
      image: map[CategoryConstants.image] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
