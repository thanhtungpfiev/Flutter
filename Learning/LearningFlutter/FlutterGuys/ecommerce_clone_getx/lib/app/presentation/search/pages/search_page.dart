import 'package:ecommerce_clone_getx/app/common/controllers/products/products_display_controller.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/product/product_card_widget.dart';
import 'package:ecommerce_clone_getx/app/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone_getx/app/core/constants/service_constants.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/search/widgets/search_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchPage extends GetView<ProductsDisplayController> {
  const SearchPage({super.key});

  @override
  ProductsDisplayController get controller =>
      Get.find<ProductsDisplayController>(
        tag: ServiceConstants.getProductsByTitleUseCaseInstance,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        height: ResponsiveUtils.height(80),
        title: SearchFieldWidget(),
      ),
      body: Obx(() {
        if (controller.state.value == ProductDisplayState.initial) {
          return Container();
        }
        if (controller.state.value == ProductDisplayState.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.products.isEmpty) {
          return _notFound();
        } else {
          return _products(controller.products);
        }
      }),
    );
  }

  Widget _notFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppVectors.notFound),
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.width(16)),
            child: Text(
              UIConstants.noSearchResults,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveUtils.fontSize(20),
              ),
            ),
          ),
        ],
      ),
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
        crossAxisSpacing: ResponsiveUtils.width(10),
        mainAxisSpacing: ResponsiveUtils.width(10),
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ProductCardWidget(productEntity: products[index]);
      },
    );
  }
}
