import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/data/order/models/add_to_cart_req_model.dart';
import 'package:ecommerce_clone_getx/app/domain/order/repository/order_repository.dart';

class AddToCartUseCase implements UseCase<Either, AddToCartReqModel> {
  AddToCartUseCase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  Future<Either> call({AddToCartReqModel? params}) async {
    return orderRepository.addToCart(params!);
  }
}
