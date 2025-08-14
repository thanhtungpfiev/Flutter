import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/data/order/models/add_to_cart_req_model.dart';

abstract class OrderRepository {
  Future<Either> addToCart(AddToCartReqModel addToCartReqModel);
  Future<Either> getCartProducts();
  Future<Either> removeCartProduct(String id);
  // Future<Either> orderRegistration(OrderRegistrationReqModel order);
  // Future<Either> getOrders();
}
