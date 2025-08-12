// import 'package:ecommerce_clone_getx/app/common/controllers/button/basic_reactive_button_controller.dart';
// import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_reactive_button.dart';
// import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
// import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
// import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
// import 'package:ecommerce_clone_getx/service_locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// class AddToBagWidget extends StatelessWidget {
//   const AddToBagWidget({required this.productEntity, super.key});

//   final ProductEntity productEntity;

//   @override
//   Widget build(BuildContext context) {
//     final buttonController = BasicReactiveButtonController();
//     return Padding(
//       padding: EdgeInsets.all(ResponsiveUtils.width(16)),
//       child: BasicReactiveButton(
//         controller: buttonController,
//         onPressed: () async {
//           await buttonController.execute(
//             usecase: sl<AddToCartUseCase>(),
//             params: AddToCartReqModel(
//               productId: productEntity.productId,
//               productTitle: productEntity.title,
//               productQuantity: context.read<ProductQuantityCubit>().state,
//               productColor: productEntity
//                   .colors[context
//                       .read<ProductColorSelectionCubit>()
//                       .selectedIndex]
//                   .title,
//               productSize:
//                   productEntity.sizes[context
//                       .read<ProductSizeSelectionCubit>()
//                       .selectedIndex],
//               productPrice: productEntity.price.toDouble(),
//               totalPrice:
//                   ProductPriceHelper.provideCurrentPrice(productEntity) *
//                   context.read<ProductQuantityCubit>().state,
//               productImage: productEntity.images[0],
//               createdDate: DateTime.now().toString(),
//             ),
//           );
//           if (buttonController.errorMessage != null) {
//             var snackbar = SnackBar(
//               content: Text(buttonController.errorMessage!),
//               backgroundColor: Colors.red,
//               behavior: SnackBarBehavior.floating,
//             );
//             if (context.mounted) {
//               ScaffoldMessenger.of(context).showSnackBar(snackbar);
//             }
//           } else {
//             Get.toNamed('Cart');
//           }
//         },
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             BlocBuilder<ProductQuantityCubit, int>(
//               builder: (context, state) {
//                 var price =
//                     ProductPriceHelper.provideCurrentPrice(productEntity) *
//                     state;
//                 return Text(
//                   "\$${price.toString()}",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: ResponsiveUtils.fontSize(14),
//                   ),
//                 );
//               },
//             ),
//             Text(
//               UIConstants.addToBag,
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//                 fontSize: ResponsiveUtils.fontSize(14),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
