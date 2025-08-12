import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/repositories/product_repository.dart';

class GetNewInUseCase implements UseCase<Either, dynamic> {
  GetNewInUseCase({required this.productRepository});

  final ProductRepository productRepository;

  @override
  Future<Either> call({dynamic params}) async {
    return await productRepository.getNewIn();
  }
}
