import 'package:ecommerce_clone/data/order/models/order_status_model.dart';
import 'package:ecommerce_clone/domain/order/entities/order_status_entity.dart';

extension OrderStatusXModel on OrderStatusModel {
  OrderStatusEntity toEntity() {
    return OrderStatusEntity(
      createdDate: createdDate,
      done: done,
      title: title,
    );
  }
}
