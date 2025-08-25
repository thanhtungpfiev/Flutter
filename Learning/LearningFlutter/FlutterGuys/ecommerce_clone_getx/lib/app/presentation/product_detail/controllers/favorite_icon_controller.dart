import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/product/usecases/add_or_remove_favorite_product_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/usecases/is_favorite_usecase.dart';
import 'package:get/get.dart';

class FavoriteIconController extends GetxController {
  FavoriteIconController({
    required this.isFavoriteUseCase,
    required this.addOrRemoveFavoriteProductUseCase,
  });

  final IsFavoriteUseCase isFavoriteUseCase;
  final AddOrRemoveFavoriteProductUseCase addOrRemoveFavoriteProductUseCase;

  final isFavorite = false.obs;
  final errorMessage = ''.obs;

  Future<void> checkIsFavorite(String productId) async {
    final result = await isFavoriteUseCase.call(params: productId);
    isFavorite.value = result;
  }

  Future<void> onTap(ProductEntity product) async {
    final result = await addOrRemoveFavoriteProductUseCase.call(
      params: product,
    );
    result.fold(
      (error) {
        errorMessage.value = error;
      },
      (data) {
        errorMessage.value = '';
        isFavorite.value = data;
      },
    );
  }
}
