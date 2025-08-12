import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/repositories/product_repository.dart';

class GetProductsByTitleUseCase implements UseCase<Either, String> {
  GetProductsByTitleUseCase({required this.productRepository});

  final ProductRepository productRepository;

  @override
  Future<Either> call({String? params}) async {
    return await productRepository.getProductsByTitle(params!);
  }
}
