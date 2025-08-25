import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/order/repository/order_repository.dart';

class GetOrdersUseCase implements UseCase<Either, dynamic> {
  GetOrdersUseCase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  Future<Either> call({dynamic params}) async {
    return orderRepository.getOrders();
  }
}
