// import 'package:ecommerce_clone/common/blocs/products/products_display_cubit.dart';
// import 'package:ecommerce_clone/common/blocs/products/products_display_state.dart';
// import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
// import 'package:ecommerce_clone/common/widgets/product/product_card_widget.dart';
// import 'package:ecommerce_clone/core/constants/service_constants.dart';
// import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
// import 'package:ecommerce_clone/domain/category/entities/category_entity.dart';
// import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
// import 'package:ecommerce_clone/service_locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CategoryProductsPage extends StatelessWidget {
//   final CategoryEntity categoryEntity;
//   const CategoryProductsPage({required this.categoryEntity, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const BasicAppBar(),
//       body: BlocProvider(
//         create:
//             (context) => sl<ProductsDisplayCubit>(
//               instanceName:
//                   ServiceConstants.getProductsByCategoryIdUseCaseInstance,
//             )..displayProducts(params: categoryEntity.categoryId),
//         child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
//           builder: (context, state) {
//             if (state is ProductsDisplayLoadingState) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state is ProductsDisplayLoadSuccessfulState) {
//               return Padding(
//                 padding: EdgeInsets.all(ResponsiveUtils.width(16)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _categoryInfo(state.products),
//                     SizedBox(height: ResponsiveUtils.height(10)),
//                     _products(state.products),
//                   ],
//                 ),
//               );
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _categoryInfo(List<ProductEntity> products) {
//     return Text(
//       '${categoryEntity.title} (${products.length})',
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: ResponsiveUtils.fontSize(16),
//       ),
//     );
//   }

//   Widget _products(List<ProductEntity> products) {
//     return Expanded(
//       child: GridView.builder(
//         itemCount: products.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: ResponsiveUtils.responsive(
//             mobile: 2,
//             tablet: 4,
//             desktop: 6,
//           ),
//           crossAxisSpacing: ResponsiveUtils.responsive(
//             mobile: ResponsiveUtils.width(10),
//             tablet: ResponsiveUtils.width(10),
//             desktop: 10,
//           ),
//           mainAxisSpacing: ResponsiveUtils.responsive(
//             mobile: ResponsiveUtils.width(10),
//             tablet: ResponsiveUtils.width(10),
//             desktop: 10,
//           ),
//           childAspectRatio: 0.8,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return ProductCardWidget(productEntity: products[index]);
//         },
//       ),
//     );
//   }
// }
