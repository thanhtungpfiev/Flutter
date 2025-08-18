// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_clone_getx/app/core/constants/order_constants.dart';
import 'package:ecommerce_clone_getx/app/data/order/extensions/product_ordered_model_extension.dart';
import 'package:ecommerce_clone_getx/app/domain/order/entities/product_ordered_entity.dart';

class OrderRegistrationReqModel {
  final List<ProductOrderedEntity> products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalPrice;

  OrderRegistrationReqModel({
    required this.products,
    required this.createdDate,
    required this.itemCount,
    required this.totalPrice,
    required this.shippingAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      OrderConstants.products: products
          .map((e) => e.fromEntity().toMap())
          .toList(),
      OrderConstants.createdDate: createdDate,
      OrderConstants.itemCount: itemCount,
      OrderConstants.totalPrice: totalPrice,
      OrderConstants.shippingAddress: shippingAddress,
    };
  }
}
