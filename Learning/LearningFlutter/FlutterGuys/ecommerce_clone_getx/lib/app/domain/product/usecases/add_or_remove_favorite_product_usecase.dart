import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/product/repositories/product_repository.dart';

class AddOrRemoveFavoriteProductUseCase
    implements UseCase<Either, ProductEntity> {
  AddOrRemoveFavoriteProductUseCase({required this.productRepository});

  final ProductRepository productRepository;
  @override
  Future<Either> call({ProductEntity? params}) async {
    return await productRepository.addOrRemoveFavoriteProduct(params!);
  }
}
