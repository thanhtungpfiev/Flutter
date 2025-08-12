import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/data/category/data_sources/category_service.dart';
import 'package:ecommerce_clone_getx/app/data/category/extensions/category_model_extension.dart';
import 'package:ecommerce_clone_getx/app/data/category/models/category_model.dart';
import 'package:ecommerce_clone_getx/app/domain/category/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl({required this.categoryService});

  final CategoryService categoryService;

  @override
  Future<Either> getCategories() async {
    var categories = await categoryService.getCategories();
    return categories.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(
            data,
          ).map((e) => CategoryModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }
}
