// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_clone/core/constants/order_constants.dart';

class ProductOrderedModel {
  final String productId;
  final String productTitle;
  final int productQuantity;
  final String productColor;
  final String productSize;
  final double productPrice;
  final double totalPrice;
  final String productImage;
  final String createdDate;
  final String id;

  ProductOrderedModel({
    required this.productId,
    required this.productTitle,
    required this.productQuantity,
    required this.productColor,
    required this.productSize,
    required this.productPrice,
    required this.totalPrice,
    required this.productImage,
    required this.createdDate,
    required this.id,
  });

  factory ProductOrderedModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderedModel(
      productId: map[OrderConstants.productId] as String,
      productTitle: map[OrderConstants.productTitle] as String,
      productQuantity: map[OrderConstants.productQuantity] as int,
      productColor: map[OrderConstants.productColor] as String,
      productSize: map[OrderConstants.productSize] as String,
      productPrice: map[OrderConstants.productPrice] as double,
      totalPrice: map[OrderConstants.totalPrice] as double,
      productImage: map[OrderConstants.productImage] as String,
      createdDate: map[OrderConstants.createdDate] as String,
      id: map[OrderConstants.id] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      OrderConstants.productId: productId,
      OrderConstants.productTitle: productTitle,
      OrderConstants.productQuantity: productQuantity,
      OrderConstants.productColor: productColor,
      OrderConstants.productSize: productSize,
      OrderConstants.productPrice: productPrice,
      OrderConstants.totalPrice: totalPrice,
      OrderConstants.productImage: productImage,
      OrderConstants.createdDate: createdDate,
      OrderConstants.id: id,
    };
  }
}
