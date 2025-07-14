import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:ecommerce_clone/domain/category/repositories/category_repository.dart';

class GetCategoriesUseCase implements UseCase<Either, dynamic> {
  GetCategoriesUseCase({required this.categoryRepository});

  final CategoryRepository categoryRepository;

  @override
  Future<Either> call({dynamic params}) async {
    return await categoryRepository.getCategories();
  }
}
