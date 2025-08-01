import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/constants/auth_constants.dart';
import 'package:ecommerce_clone/core/constants/message_constants.dart';
import 'package:ecommerce_clone/core/constants/product_constants.dart';
import 'package:ecommerce_clone/data/product/data_sources/product_service.dart';
import 'package:ecommerce_clone/data/product/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductFirebaseService extends ProductService {
  @override
  Future<Either> getTopSelling() async {
    try {
      var returnedData =
          await FirebaseFirestore.instance
              .collection(ProductConstants.products)
              .where(ProductConstants.salesNumber, isGreaterThanOrEqualTo: 20)
              .get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }

  @override
  Future<Either> getNewIn() async {
    try {
      var returnedData =
          await FirebaseFirestore.instance
              .collection(ProductConstants.products)
              .where(
                ProductConstants.createdDate,
                isGreaterThanOrEqualTo: DateTime(2025, 07, 21),
              )
              .get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }

  @override
  Future<Either> getProductsByCategoryId(String categoryId) async {
    try {
      var returnedData =
          await FirebaseFirestore.instance
              .collection(ProductConstants.products)
              .where(ProductConstants.categoryId, isEqualTo: categoryId)
              .get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }

  @override
  Future<Either> getProductsByTitle(String title) async {
    try {
      var returnedData =
          await FirebaseFirestore.instance
              .collection(ProductConstants.products)
              .get();
      var filtered =
          returnedData.docs
              .where(
                (e) => (e.data()[ProductConstants.title] as String)
                    .toLowerCase()
                    .contains(title.toLowerCase()),
              )
              .map((e) => e.data())
              .toList();
      return Right(filtered);
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteProduct(ProductModel product) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var products =
          await FirebaseFirestore.instance
              .collection(AuthConstants.users)
              .doc(user!.uid)
              .collection(ProductConstants.favorites)
              .where(ProductConstants.productId, isEqualTo: product.productId)
              .get();

      if (products.docs.isNotEmpty) {
        await products.docs.first.reference.delete();
        return const Right(false);
      } else {
        await FirebaseFirestore.instance
            .collection(AuthConstants.users)
            .doc(user.uid)
            .collection(ProductConstants.favorites)
            .add(product.toMap());
        return const Right(true);
      }
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }

  @override
  Future<bool> isFavorite(String productId) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var products =
          await FirebaseFirestore.instance
              .collection(AuthConstants.users)
              .doc(user!.uid)
              .collection(ProductConstants.favorites)
              .where(ProductConstants.productId, isEqualTo: productId)
              .get();

      if (products.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getFavoritesProducts() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var returnedData =
          await FirebaseFirestore.instance
              .collection(AuthConstants.users)
              .doc(user!.uid)
              .collection(ProductConstants.favorites)
              .get();
      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }
}
