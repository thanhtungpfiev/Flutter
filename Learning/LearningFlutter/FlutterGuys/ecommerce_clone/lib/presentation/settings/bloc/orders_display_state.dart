import 'package:ecommerce_clone/domain/order/entities/order_entity.dart';

abstract class OrdersDisplayState {}

class OrdersDisplayLoadingState extends OrdersDisplayState {}

class OrdersDisplayLoadSuccessState extends OrdersDisplayState {
  final List<OrderEntity> orders;
  OrdersDisplayLoadSuccessState({required this.orders});
}

class OrdersDisplayLoadErrorState extends OrdersDisplayState {
  final String errorMessage;
  OrdersDisplayLoadErrorState({required this.errorMessage});
}
