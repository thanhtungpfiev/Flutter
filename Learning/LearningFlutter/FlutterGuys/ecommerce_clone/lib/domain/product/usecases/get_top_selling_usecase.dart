import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:ecommerce_clone/domain/product/repositories/product_repository.dart';

class GetTopSellingUseCase implements UseCase<Either, dynamic> {
  GetTopSellingUseCase({required this.productRepository});

  final ProductRepository productRepository;

  @override
  Future<Either> call({dynamic params}) async {
    return await productRepository.getTopSelling();
  }
}
