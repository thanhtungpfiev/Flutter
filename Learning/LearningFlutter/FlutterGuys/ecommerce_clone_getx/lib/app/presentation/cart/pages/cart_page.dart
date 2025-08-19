import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/order/entities/product_ordered_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/cart/controllers/cart_products_display_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/cart/widgets/checkout_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/cart/widgets/product_ordered_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CartPage extends GetView<CartProductsDisplayController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text(UIConstants.cart)),
      body: Obx(() {
        if (controller.state.value == CartProductsDisplayState.loading) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.state.value == CartProductsDisplayState.success) {
          if (controller.products.isEmpty) {
            return Center(child: _cartIsEmpty());
          } else {
            return Stack(
              children: [
                _products(controller.products),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CheckoutWidget(products: controller.products),
                ),
              ],
            );
          }
        }
        if (controller.state.value == CartProductsDisplayState.error) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return Container();
      }),
    );
  }

  Widget _products(List<ProductOrderedEntity> products) {
    return ListView.separated(
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      itemBuilder: (context, index) {
        return ProductOrderedCardWidget(productOrderedEntity: products[index]);
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: ResponsiveUtils.height(10)),
      itemCount: products.length,
    );
  }

  Widget _cartIsEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppVectors.cartBag),
        SizedBox(height: ResponsiveUtils.height(20)),
        Text(
          UIConstants.cartIsEmpty,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveUtils.fontSize(20),
          ),
        ),
      ],
    );
  }
}
