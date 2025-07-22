import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:ecommerce_clone/domain/product/repositories/product_repository.dart';

class GetProductsByTitleUseCase implements UseCase<Either, String> {
  GetProductsByTitleUseCase({required this.productRepository});

  final ProductRepository productRepository;

  @override
  Future<Either> call({String? params}) async {
    return await productRepository.getProductsByTitle(params!);
  }
}
