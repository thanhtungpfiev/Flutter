import 'package:ecommerce_clone_getx/app/common/controllers/products/products_display_controller.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/product/product_card_widget.dart';
import 'package:ecommerce_clone_getx/app/core/constants/service_constants.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFavoritesPage extends GetView<ProductsDisplayController> {
  const MyFavoritesPage({super.key});

  @override
  ProductsDisplayController get controller =>
      Get.find<ProductsDisplayController>(
        tag: ServiceConstants.getFavoritesProductsUseCaseInstance,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: Text(UIConstants.myFavorites)),
      body: Obx(() {
        if (controller.state.value == ProductDisplayState.initial) {
          controller.displayProducts();
        }

        if (controller.state.value == ProductDisplayState.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.state.value == ProductDisplayState.success) {
          return _products(controller.products);
        }
        if (controller.state.value == ProductDisplayState.error) {
          return const Center(child: Text(UIConstants.pleaseTryAgain));
        }
        return Container();
      }),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return GridView.builder(
      itemCount: products.length,
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveUtils.responsive(
          mobile: 2,
          tablet: 4,
          desktop: 6,
        ),
        crossAxisSpacing: ResponsiveUtils.responsive(
          mobile: ResponsiveUtils.width(10),
          tablet: ResponsiveUtils.width(10),
          desktop: 10,
        ),
        mainAxisSpacing: ResponsiveUtils.responsive(
          mobile: ResponsiveUtils.width(10),
          tablet: ResponsiveUtils.width(10),
          desktop: 10,
        ),
        childAspectRatio: 0.8,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ProductCardWidget(
          productEntity: products[index],
          onReturn: () {
            // Refresh the favorites list when returning from product detail
            controller.displayProducts();
          },
        );
      },
    );
  }
}
