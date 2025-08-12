import 'dart:ui';

import 'package:ecommerce_clone_getx/app/common/controllers/products/products_display_controller.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/product/product_card_widget.dart';
import 'package:ecommerce_clone_getx/app/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone_getx/app/core/constants/service_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewInWidget extends GetView<ProductsDisplayController> {
  const NewInWidget({super.key});

  @override
  ProductsDisplayController get controller =>
      Get.find<ProductsDisplayController>(
        tag: ServiceConstants.getNewInUseCaseInstance,
      );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.state.value == ProductDisplayState.initial) {
        controller.displayProducts();
      }
      if (controller.state.value == ProductDisplayState.loading) {
        return const CircularProgressIndicator();
      }
      if (controller.state.value == ProductDisplayState.success) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _newIn(),
            SizedBox(height: ResponsiveUtils.height(20)),
            _products(controller.products),
          ],
        );
      }
      return Container();
    });
  }

  Widget _newIn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'New In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            fontSize: ResponsiveUtils.fontSize(16),
          ),
        ),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return SizedBox(
      height: ResponsiveUtils.height(300),
      child: Builder(
        builder: (context) => ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.width(16),
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCardWidget(productEntity: products[index]);
            },
            separatorBuilder: (context, index) =>
                SizedBox(width: ResponsiveUtils.width(10)),
            itemCount: products.length,
          ),
        ),
      ),
    );
  }
}
