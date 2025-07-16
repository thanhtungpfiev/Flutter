import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/data/product/data_sources/product_service.dart';
import 'package:ecommerce_clone/data/product/extensions/product_model_extension.dart';
import 'package:ecommerce_clone/data/product/models/product_model.dart';
import 'package:ecommerce_clone/domain/product/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  ProductRepositoryImpl({required this.productService});

  final ProductService productService;

  @override
  Future<Either> getTopSelling() async {
    var returnedData = await productService.getTopSelling();
    return returnedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(
          List.from(
            data,
          ).map((e) => ProductModel.fromMap(e).toEntity()).toList(),
        );
      },
    );
  }

  // @override
  // Future<Either> getNewIn() async {
  //   var returnedData = await sl<ProductFirebaseService>().getNewIn();
  //   return returnedData.fold(
  //     (error) {
  //       return Left(error);
  //     },
  //     (data) {
  //       return Right(
  //         List.from(
  //           data,
  //         ).map((e) => ProductModel.fromMap(e).toEntity()).toList(),
  //       );
  //     },
  //   );
  // }

  // @override
  // Future<Either> getProductsByCategoryId(String categoryId) async {
  //   var returnedData = await sl<ProductFirebaseService>()
  //       .getProductsByCategoryId(categoryId);
  //   return returnedData.fold(
  //     (error) {
  //       return Left(error);
  //     },
  //     (data) {
  //       return Right(
  //         List.from(
  //           data,
  //         ).map((e) => ProductModel.fromMap(e).toEntity()).toList(),
  //       );
  //     },
  //   );
  // }

  // @override
  // Future<Either> getProductsByTitle(String title) async {
  //   var returnedData = await sl<ProductFirebaseService>().getProductsByTitle(
  //     title,
  //   );
  //   return returnedData.fold(
  //     (error) {
  //       return Left(error);
  //     },
  //     (data) {
  //       return Right(
  //         List.from(
  //           data,
  //         ).map((e) => ProductModel.fromMap(e).toEntity()).toList(),
  //       );
  //     },
  //   );
  // }

  // @override
  // Future<Either> addOrRemoveFavoriteProduct(ProductEntity product) async {
  //   var returnedData = await sl<ProductFirebaseService>()
  //       .addOrRemoveFavoriteProduct(product);
  //   return returnedData.fold(
  //     (error) {
  //       return Left(error);
  //     },
  //     (data) {
  //       return Right(data);
  //     },
  //   );
  // }

  // @override
  // Future<bool> isFavorite(String productId) async {
  //   return await sl<ProductFirebaseService>().isFavorite(productId);
  // }

  // @override
  // Future<Either> getFavoritesProducts() async {
  //   var returnedData =
  //       await sl<ProductFirebaseService>().getFavoritesProducts();
  //   return returnedData.fold(
  //     (error) {
  //       return Left(error);
  //     },
  //     (data) {
  //       return Right(
  //         List.from(
  //           data,
  //         ).map((e) => ProductModel.fromMap(e).toEntity()).toList(),
  //       );
  //     },
  //   );
  // }
}
