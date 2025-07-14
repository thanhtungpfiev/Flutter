import 'package:dartz/dartz.dart';

abstract class CategoryService {
  Future<Either> getCategories();
}
