import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/repositories/product_repository.dart';

class IsFavoriteUseCase implements UseCase<bool, String> {
  IsFavoriteUseCase({required this.productRepository});

  final ProductRepository productRepository;

  @override
  Future<bool> call({String? params}) async {
    return await productRepository.isFavorite(params!);
  }
}
