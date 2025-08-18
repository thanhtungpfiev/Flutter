import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/data/order/models/order_registration_req.dart';
import 'package:ecommerce_clone_getx/app/domain/order/repository/order_repository.dart';

class OrderRegistrationUseCase
    implements UseCase<Either, OrderRegistrationReqModel> {
  OrderRegistrationUseCase({required this.orderRepository});

  final OrderRepository orderRepository;

  @override
  Future<Either> call({OrderRegistrationReqModel? params}) async {
    return orderRepository.orderRegistration(params!);
  }
}
