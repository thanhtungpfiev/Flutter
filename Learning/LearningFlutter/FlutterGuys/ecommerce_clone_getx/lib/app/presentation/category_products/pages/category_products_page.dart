import 'package:ecommerce_clone_getx/app/common/controllers/products/products_display_controller.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/product/product_card_widget.dart';
import 'package:ecommerce_clone_getx/app/core/constants/service_constants.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/category/entities/category_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryProductsPage extends GetView<ProductsDisplayController> {
  const CategoryProductsPage({super.key});

  @override
  ProductsDisplayController get controller =>
      Get.find<ProductsDisplayController>(
        tag: ServiceConstants.getProductsByCategoryIdUseCaseInstance,
      );

  @override
  Widget build(BuildContext context) {
    final CategoryEntity categoryEntity =
        Get.arguments[UIConstants.categoryEntity];
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Obx(() {
        if (controller.state.value == ProductDisplayState.initial) {
          controller.displayProducts(params: categoryEntity.categoryId);
        }
        if (controller.state.value == ProductDisplayState.loading) {
          return CircularProgressIndicator();
        }
        if (controller.state.value == ProductDisplayState.success) {
          return Padding(
            padding: EdgeInsets.all(ResponsiveUtils.width(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _categoryInfo(categoryEntity, controller.products),
                SizedBox(height: ResponsiveUtils.height(10)),
                _products(controller.products),
              ],
            ),
          );
        }
        return Container();
      }),
    );
  }

  Widget _categoryInfo(
    CategoryEntity categoryEntity,
    List<ProductEntity> products,
  ) {
    return Text(
      '${categoryEntity.title} (${products.length})',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: ResponsiveUtils.fontSize(16),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
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
          return ProductCardWidget(productEntity: products[index]);
        },
      ),
    );
  }
}
