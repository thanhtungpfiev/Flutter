// import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
// import 'package:ecommerce_clone/common/helper/theme/theme_helper.dart';
// import 'package:ecommerce_clone/core/constants/ui_constants.dart';
// import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
// import 'package:ecommerce_clone/presentation/settings/pages/my_favorites_page.dart';
// import 'package:flutter/material.dart';

// class MyFavoritesTileWidget extends StatelessWidget {
//   const MyFavoritesTileWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         AppNavigator.push(context, const MyFavoritesPage());
//       },
//       child: Container(
//         height: ResponsiveUtils.height(70),
//         padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
//         decoration: BoxDecoration(
//           color: ThemeHelper.getSecondBackground(context),
//           borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               UIConstants.myFavorites,
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: ResponsiveUtils.fontSize(16),
//               ),
//             ),
//             Icon(Icons.arrow_forward_ios_rounded),
//           ],
//         ),
//       ),
//     );
//   }
// }
