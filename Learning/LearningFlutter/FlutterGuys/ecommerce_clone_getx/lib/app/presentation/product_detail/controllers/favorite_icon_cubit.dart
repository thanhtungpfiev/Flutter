// import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
// import 'package:ecommerce_clone/domain/product/usecases/add_or_remove_favorite_product_usecase.dart';
// import 'package:ecommerce_clone/domain/product/usecases/is_favorite_usecase.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FavoriteIconCubit extends Cubit<bool> {
//   FavoriteIconCubit({
//     required this.isFavoriteUseCase,
//     required this.addOrRemoveFavoriteProductUseCase,
//   }) : super(false);

//   final IsFavoriteUseCase isFavoriteUseCase;
//   final AddOrRemoveFavoriteProductUseCase addOrRemoveFavoriteProductUseCase;

//   void isFavorite(String productId) async {
//     var result = await isFavoriteUseCase.call(params: productId);
//     emit(result);
//   }

//   void onTap(ProductEntity product) async {
//     var result = await addOrRemoveFavoriteProductUseCase.call(params: product);
//     result.fold((error) {}, (data) {
//       emit(data);
//     });
//   }
// }
