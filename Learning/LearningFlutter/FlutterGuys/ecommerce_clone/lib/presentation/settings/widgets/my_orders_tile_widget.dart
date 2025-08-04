import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/utils/theme_utils.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/presentation/settings/pages/my_orders_page.dart';
import 'package:flutter/material.dart';

class MyOrdersTileWidget extends StatelessWidget {
  const MyOrdersTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, const MyOrdersPage());
      },
      child: Container(
        height: ResponsiveUtils.height(70),
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
        decoration: BoxDecoration(
          color: ThemeUtils.getSecondBackground(context),
          borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              UIConstants.myOrders,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: ResponsiveUtils.fontSize(16),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
