import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/category/repositories/category_repository.dart';

class GetCategoriesUseCase implements UseCase<Either, dynamic> {
  GetCategoriesUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  @override
  Future<Either> call({dynamic params}) async {
    return await categoryRepository.getCategories();
  }
}
