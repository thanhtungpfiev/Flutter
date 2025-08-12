// import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
// import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
// import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
// import 'package:flutter/material.dart';

// class ProductPriceWidget extends StatelessWidget {
//   const ProductPriceWidget({required this.productEntity, super.key});

//   final ProductEntity productEntity;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
//       child: Text(
//         "\$${productEntity.discountedPrice != 0 ? productEntity.discountedPrice.toStringAsFixed(2) : productEntity.price.toStringAsFixed(2)}",
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           color: AppColors.primary,
//           fontSize: 14,
//         ),
//       ),
//     );
//   }
// }
