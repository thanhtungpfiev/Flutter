import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/order/repository/order_repository.dart';

class GetCartProductsUseCase implements UseCase<Either, dynamic> {
  GetCartProductsUseCase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  Future<Either> call({dynamic params}) async {
    return orderRepository.getCartProducts();
  }
}
