import 'dart:ui';

import 'package:ecommerce_clone_getx/app/common/controllers/products/products_display_controller.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/product/product_card_widget.dart';
import 'package:ecommerce_clone_getx/app/core/constants/service_constants.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopSellingWidget extends GetView<ProductsDisplayController> {
  const TopSellingWidget({super.key});

  @override
  ProductsDisplayController get controller =>
      Get.find<ProductsDisplayController>(
        tag: ServiceConstants.getTopSellingUseCaseInstance,
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
            _topSelling(),
            SizedBox(height: ResponsiveUtils.height(20)),
            _products(controller.products),
          ],
        );
      }
      if (controller.state.value == ProductDisplayState.error) {
        return const Center(child: Text('Error loading top selling products'));
      }
      return Container();
    });
  }

  Widget _topSelling() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          UIConstants.topSelling,
          style: TextStyle(
            fontWeight: FontWeight.bold,
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
