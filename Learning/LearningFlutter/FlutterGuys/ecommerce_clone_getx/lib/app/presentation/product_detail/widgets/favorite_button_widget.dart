// import 'package:ecommerce_clone/common/helper/theme/theme_helper.dart';
// import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
// import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
// import 'package:ecommerce_clone/presentation/product_detail/bloc/favorite_icon_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FavoriteButtonWidget extends StatelessWidget {
//   final ProductEntity productEntity;
//   const FavoriteButtonWidget({required this.productEntity, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         context.read<FavoriteIconCubit>().onTap(productEntity);
//       },
//       icon: Container(
//         height: ResponsiveUtils.height(40),
//         width: ResponsiveUtils.width(40),
//         decoration: BoxDecoration(
//           color: ThemeHelper.getSecondBackground(context),
//           shape: BoxShape.circle,
//         ),
//         child: BlocBuilder<FavoriteIconCubit, bool>(
//           builder:
//               (context, state) => Icon(
//                 state ? Icons.favorite : Icons.favorite_outline,
//                 size: ResponsiveUtils.fontSize(15),
//                 color: ThemeHelper.getIconColor(context),
//               ),
//         ),
//       ),
//     );
//   }
// }
