import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/add_to_bag_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/favorite_button_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/product_images_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/product_price_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/product_quantity_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/product_title_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/selected_color_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/selected_size_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductEntity productEntity =
        Get.arguments[UIConstants.productEntity];

    return Scaffold(
      appBar: BasicAppBar(
        hideBack: false,
        action: FavoriteButtonWidget(productEntity: productEntity),
      ),
      bottomNavigationBar: AddToBagWidget(productEntity: productEntity),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImagesWidget(productEntity: productEntity),
            SizedBox(height: ResponsiveUtils.height(10)),
            ProductTitleWidget(productEntity: productEntity),
            SizedBox(height: ResponsiveUtils.height(10)),
            ProductPriceWidget(productEntity: productEntity),
            SizedBox(height: ResponsiveUtils.height(20)),
            SelectedSizeWidget(productEntity: productEntity),
            SizedBox(height: ResponsiveUtils.height(15)),
            SelectedColorWidget(productEntity: productEntity),
            SizedBox(height: ResponsiveUtils.height(15)),
            ProductQuantityWidget(productEntity: productEntity),
          ],
        ),
      ),
    );
  }
}
