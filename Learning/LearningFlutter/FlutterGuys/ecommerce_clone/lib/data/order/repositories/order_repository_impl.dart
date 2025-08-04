import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/data/order/data_sources/order_service.dart';
import 'package:ecommerce_clone/data/order/extensions/order_model_extension.dart';
import 'package:ecommerce_clone/data/order/extensions/product_ordered_model_extension.dart';
import 'package:ecommerce_clone/data/order/models/add_to_cart_req_model.dart';
import 'package:ecommerce_clone/data/order/models/order_model.dart';
import 'package:ecommerce_clone/data/order/models/order_registration_req.dart';
import 'package:ecommerce_clone/data/order/models/product_ordered_model.dart';
import 'package:ecommerce_clone/domain/order/repository/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderService orderService;

  OrderRepositoryImpl({required this.orderService});

  @override
  Future<Either> addToCart(AddToCartReqModel addToCartReqModel) async {
    return orderService.addToCart(addToCartReqModel);
  }

  @override
  Future<Either> getCartProducts() async {
    var returnedData = await orderService.getCartProducts();
    return returnedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(
            data,
          ).map((e) => ProductOrderedModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }

  @override
  Future<Either> removeCartProduct(String id) async {
    var returnedData = await orderService.removeCartProduct(id);
    return returnedData.fold(
      (error) {
        return Left(error);
      },
      (message) {
        return Right(message);
      },
    );
  }

  @override
  Future<Either> orderRegistration(OrderRegistrationReqModel order) async {
    var returnedData = await orderService.orderRegistration(order);
    return returnedData.fold(
      (error) {
        return Left(error);
      },
      (message) {
        return Right(message);
      },
    );
  }

  @override
  Future<Either> getOrders() async {
    var returnedData = await orderService.getOrders();
    return returnedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(data).map((e) => OrderModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }
}
