import 'package:ecommerce_clone/data/order/extensions/order_status_model_extension.dart';
import 'package:ecommerce_clone/data/order/extensions/product_ordered_model_extension.dart';
import 'package:ecommerce_clone/data/order/models/order_model.dart';
import 'package:ecommerce_clone/domain/order/entities/order_entity.dart';

extension OrderXModel on OrderModel {
  OrderEntity toEntity() {
    return OrderEntity(
      products: products.map((e) => e.toEntity()).toList(),
      createdDate: createdDate,
      shippingAddress: shippingAddress,
      itemCount: itemCount,
      totalPrice: totalPrice,
      code: code,
      orderStatus: orderStatus.map((e) => e.toEntity()).toList(),
    );
  }
}
