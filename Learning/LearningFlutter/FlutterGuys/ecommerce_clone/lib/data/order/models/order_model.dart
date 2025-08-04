// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_clone/core/constants/order_constants.dart';
import 'package:ecommerce_clone/data/order/models/order_status_model.dart';
import 'package:ecommerce_clone/data/order/models/product_ordered_model.dart';

class OrderModel {
  final List<ProductOrderedModel> products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalPrice;
  final String code;
  final List<OrderStatusModel> orderStatus;

  OrderModel({
    required this.products,
    required this.createdDate,
    required this.shippingAddress,
    required this.itemCount,
    required this.totalPrice,
    required this.code,
    required this.orderStatus,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      products: List<ProductOrderedModel>.from(
        map[OrderConstants.products].map((e) => ProductOrderedModel.fromMap(e)),
      ),
      createdDate: map[OrderConstants.createdDate] as String,
      shippingAddress: map[OrderConstants.shippingAddress] as String,
      itemCount: map[OrderConstants.itemCount] as int,
      totalPrice: map[OrderConstants.totalPrice] as double,
      code: map[OrderConstants.code] as String,
      orderStatus: List<OrderStatusModel>.from(
        map[OrderConstants.orderStatus].map((e) => OrderStatusModel.fromMap(e)),
      ),
    );
  }
}
