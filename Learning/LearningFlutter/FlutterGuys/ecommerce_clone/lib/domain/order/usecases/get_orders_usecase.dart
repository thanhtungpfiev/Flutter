import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:ecommerce_clone/domain/order/repository/order_repository.dart';

class GetOrdersUseCase implements UseCase<Either, dynamic> {
  GetOrdersUseCase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  Future<Either> call({dynamic params}) async {
    return orderRepository.getOrders();
  }
}
