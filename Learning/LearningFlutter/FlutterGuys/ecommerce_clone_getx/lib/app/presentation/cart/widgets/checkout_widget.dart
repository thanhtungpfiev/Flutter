import 'package:ecommerce_clone_getx/app/common/helper/cart/cart_helper.dart';
import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/order/entities/product_ordered_entity.dart';
import 'package:flutter/material.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({required this.products, super.key});

  final List<ProductOrderedEntity> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      height: ResponsiveUtils.screenHeight / 3.5,
      color: ThemeHelper.getSecondBackground(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                UIConstants.subtotal,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
              Text(
                '\$${CartHelper.calculateCartSubtotal(products).toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                UIConstants.shippingCost,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
              Text(
                '\$8',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                UIConstants.tax,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
              Text(
                '\$0.0',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                UIConstants.total,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
              Text(
                '\$${CartHelper.calculateCartSubtotal(products) + 8}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveUtils.fontSize(16),
                ),
              ),
            ],
          ),
          BasicAppButton(
            onPressed: () {
              // AppNavigator.push(context, CheckOutPage(products: products));
            },
            title: UIConstants.checkout,
          ),
        ],
      ),
    );
  }
}
