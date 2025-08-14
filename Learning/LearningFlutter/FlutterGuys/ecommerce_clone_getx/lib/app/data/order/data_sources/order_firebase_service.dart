import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/constants/auth_constants.dart';
import 'package:ecommerce_clone_getx/app/core/constants/message_constants.dart';
import 'package:ecommerce_clone_getx/app/core/constants/order_constants.dart';
import 'package:ecommerce_clone_getx/app/data/order/data_sources/order_service.dart';
import 'package:ecommerce_clone_getx/app/data/order/models/add_to_cart_req_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderFirebaseService extends OrderService {
  @override
  Future<Either> addToCart(AddToCartReqModel addToCartReqModel) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection(AuthConstants.users)
          .doc(user!.uid)
          .collection(OrderConstants.cart)
          .add(addToCartReqModel.toMap());
      return const Right(MessageConstants.addToCartSuccess);
    } catch (e) {
      return const Left(MessageConstants.pleaseRetryWithDot);
    }
  }

  @override
  Future<Either> getCartProducts() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData = await FirebaseFirestore.instance
          .collection(AuthConstants.users)
          .doc(user!.uid)
          .collection(OrderConstants.cart)
          .get();

      List<Map> products = [];
      for (var item in returnedData.docs) {
        var data = item.data();
        data.addAll({OrderConstants.id: item.id});
        products.add(data);
      }
      return Right(products);
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }

  @override
  Future<Either> removeCartProduct(String id) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection(AuthConstants.users)
          .doc(user!.uid)
          .collection(OrderConstants.cart)
          .doc(id)
          .delete();
      return const Right(MessageConstants.productRemovedSuccess);
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }

  // @override
  // Future<Either> orderRegistration(OrderRegistrationReqModel order) async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;
  //     await FirebaseFirestore.instance
  //         .collection(AuthConstants.users)
  //         .doc(user!.uid)
  //         .collection(OrderConstants.orders)
  //         .add(order.toMap());

  //     for (var item in order.products) {
  //       await FirebaseFirestore.instance
  //           .collection(AuthConstants.users)
  //           .doc(user.uid)
  //           .collection(OrderConstants.cart)
  //           .doc(item.id)
  //           .delete();
  //     }

  //     return const Right(MessageConstants.orderRegisteredSuccess);
  //   } catch (e) {
  //     return const Left(MessageConstants.pleaseRetry);
  //   }
  // }

  // @override
  // Future<Either> getOrders() async {
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;
  //     var returnedData = await FirebaseFirestore.instance
  //         .collection(AuthConstants.users)
  //         .doc(user!.uid)
  //         .collection(OrderConstants.orders)
  //         .get();
  //     return Right(returnedData.docs.map((e) => e.data()).toList());
  //   } catch (e) {
  //     return const Left(MessageConstants.pleaseRetry);
  //   }
  // }
}
