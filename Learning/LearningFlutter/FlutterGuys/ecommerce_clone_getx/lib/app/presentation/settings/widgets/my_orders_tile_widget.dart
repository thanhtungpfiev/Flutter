import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersTileWidget extends StatelessWidget {
  const MyOrdersTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.myOrders);
      },
      child: Container(
        height: ResponsiveUtils.height(70),
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
        decoration: BoxDecoration(
          color: ThemeHelper.getSecondBackground(context),
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
