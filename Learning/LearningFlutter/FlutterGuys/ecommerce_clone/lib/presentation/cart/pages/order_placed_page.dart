import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce_clone/core/configs/assets/app_images.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/presentation/home/pages/home_page.dart';
import 'package:flutter/material.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(AppImages.orderPlaced),
          ),
          SizedBox(height: ResponsiveUtils.height(60)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ResponsiveUtils.height(300),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.width(16),
              ),
              decoration: BoxDecoration(
                color: AppColors.secondBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ResponsiveUtils.radius(20)),
                  topRight: Radius.circular(ResponsiveUtils.radius(20)),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    UIConstants.orderPlacedSuccessfully,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveUtils.fontSize(20),
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.height(30)),
                  BasicAppButton(
                    title: UIConstants.finish,
                    onPressed: () {
                      AppNavigator.pushAndRemoveUntil(
                        context,
                        const HomePage(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
