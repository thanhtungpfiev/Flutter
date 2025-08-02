import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:ecommerce_clone/domain/order/repository/order_repository.dart';

class RemoveCartProductUseCase implements UseCase<Either, String> {
  RemoveCartProductUseCase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  Future<Either> call({String? params}) async {
    return orderRepository.removeCartProduct(params!);
  }
}
