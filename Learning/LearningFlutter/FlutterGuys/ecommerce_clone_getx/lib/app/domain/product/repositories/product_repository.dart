import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either> getTopSelling();
  // Future<Either> getNewIn();
  // Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
  // Future<Either> addOrRemoveFavoriteProduct(ProductEntity product);
  // Future<bool> isFavorite(String productId);
  // Future<Either> getFavoritesProducts();
}
