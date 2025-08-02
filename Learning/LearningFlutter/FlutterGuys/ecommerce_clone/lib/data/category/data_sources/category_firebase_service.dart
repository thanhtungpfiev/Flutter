import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/constants/category_constants.dart';
import 'package:ecommerce_clone/core/constants/message_constants.dart';
import 'package:ecommerce_clone/data/category/data_sources/category_service.dart';

class CategoryFirebaseService extends CategoryService {
  @override
  Future<Either> getCategories() async {
    try {
      var categories =
          await FirebaseFirestore.instance
              .collection(CategoryConstants.categories)
              .get();
      return Right(categories.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }
}
