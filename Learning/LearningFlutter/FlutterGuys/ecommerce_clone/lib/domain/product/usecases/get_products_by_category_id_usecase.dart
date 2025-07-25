import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:ecommerce_clone/domain/product/repositories/product_repository.dart';

class GetProductsByCategoryIdUseCase implements UseCase<Either, String> {
  GetProductsByCategoryIdUseCase({required this.productRepository});

  final ProductRepository productRepository;

  @override
  Future<Either> call({String? params}) async {
    return await productRepository.getProductsByCategoryId(params!);
  }
}
