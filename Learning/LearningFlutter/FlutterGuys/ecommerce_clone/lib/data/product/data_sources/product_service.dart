import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/data/product/models/product_model.dart';

abstract class ProductService {
  Future<Either> getTopSelling();
  Future<Either> getNewIn();
  Future<Either> getProductsByCategoryId(String categoryId);
  Future<Either> getProductsByTitle(String title);
  Future<Either> addOrRemoveFavoriteProduct(ProductModel product);
  Future<bool> isFavorite(String productId);
  Future<Either> getFavoritesProducts();
}
