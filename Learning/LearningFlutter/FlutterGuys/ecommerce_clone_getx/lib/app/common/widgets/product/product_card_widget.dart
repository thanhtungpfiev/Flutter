// import 'package:ecommerce_clone/common/helper/images/image_display_helper.dart';
// import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
// import 'package:ecommerce_clone/common/helper/theme/theme_helper.dart';
// import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
// import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
// import 'package:ecommerce_clone/presentation/product_detail/pages/product_detail_page.dart';
// import 'package:flutter/material.dart';

// class ProductCardWidget extends StatelessWidget {
//   final ProductEntity productEntity;
//   const ProductCardWidget({required this.productEntity, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         AppNavigator.push(
//           context,
//           ProductDetailPage(productEntity: productEntity),
//         );
//       },
//       child: Container(
//         width: ResponsiveUtils.width(180),
//         decoration: BoxDecoration(
//           color: ThemeHelper.getSecondBackground(context),
//           borderRadius: BorderRadius.circular(ResponsiveUtils.radius(8)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               flex: 4,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: NetworkImage(
//                       ImageDisplayHelper.generateProductImageURL(
//                         productEntity.images[0],
//                       ),
//                     ),
//                   ),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(ResponsiveUtils.radius(8)),
//                     topRight: Radius.circular(ResponsiveUtils.radius(8)),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: Padding(
//                 padding: EdgeInsets.all(ResponsiveUtils.width(8)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       productEntity.title,
//                       style: TextStyle(
//                         fontSize: ResponsiveUtils.fontSize(12),
//                         overflow: TextOverflow.ellipsis,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           productEntity.discountedPrice == 0
//                               ? "${productEntity.price.toStringAsFixed(2)}\$"
//                               : "${productEntity.discountedPrice.toStringAsFixed(2)}\$",
//                           style: TextStyle(
//                             fontSize: ResponsiveUtils.fontSize(12),
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                         SizedBox(width: ResponsiveUtils.width(10)),
//                         Text(
//                           productEntity.discountedPrice == 0
//                               ? ''
//                               : "${productEntity.price.toStringAsFixed(2)}\$",
//                           style: TextStyle(
//                             fontSize: ResponsiveUtils.fontSize(12),
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w300,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
