import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/data/order/models/add_to_cart_req_model.dart';

abstract class OrderService {
  Future<Either> addToCart(AddToCartReqModel addToCartReqModel);
  Future<Either> getCartProducts();
  // Future<Either> removeCartProduct(String id);
  // Future<Either> orderRegistration(OrderRegistrationReq order);
  // Future<Either> getOrders();
}
