// import 'package:ecommerce_clone/common/helper/theme/theme_helper.dart';
// import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
// import 'package:ecommerce_clone/core/constants/ui_constants.dart';
// import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
// import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
// import 'package:ecommerce_clone/presentation/product_detail/bloc/product_quantity_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductQuantityWidget extends StatelessWidget {
//   const ProductQuantityWidget({required this.productEntity, super.key});

//   final ProductEntity productEntity;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: ResponsiveUtils.height(60),
//       margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
//       padding: EdgeInsets.only(left: ResponsiveUtils.width(12)),
//       decoration: BoxDecoration(
//         color: ThemeHelper.getSecondBackground(context),
//         borderRadius: BorderRadius.circular(ResponsiveUtils.radius(100)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             UIConstants.quantity,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontSize: ResponsiveUtils.fontSize(14),
//             ),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () {
//                   context.read<ProductQuantityCubit>().decrement();
//                 },
//                 icon: Container(
//                   height: ResponsiveUtils.height(40),
//                   width: ResponsiveUtils.width(40),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.primary,
//                   ),
//                   child: Center(
//                     child: Icon(Icons.remove, size: ResponsiveUtils.width(30)),
//                   ),
//                 ),
//               ),
//               SizedBox(width: ResponsiveUtils.width(10)),
//               BlocBuilder<ProductQuantityCubit, int>(
//                 builder:
//                     (context, state) => Text(
//                       state.toString(),
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: ResponsiveUtils.fontSize(18),
//                       ),
//                     ),
//               ),
//               SizedBox(width: ResponsiveUtils.width(10)),
//               IconButton(
//                 onPressed: () {
//                   context.read<ProductQuantityCubit>().increment();
//                 },
//                 icon: Container(
//                   height: ResponsiveUtils.height(40),
//                   width: ResponsiveUtils.width(40),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.primary,
//                   ),
//                   child: Center(
//                     child: Icon(Icons.add, size: ResponsiveUtils.width(30)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
