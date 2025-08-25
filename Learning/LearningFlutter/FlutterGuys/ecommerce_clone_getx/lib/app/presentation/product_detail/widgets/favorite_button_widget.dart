import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/favorite_icon_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteButtonWidget extends GetView<FavoriteIconController> {
  final ProductEntity productEntity;
  const FavoriteButtonWidget({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the favorite status when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.checkIsFavorite(productEntity.productId);
    });

    return IconButton(
      onPressed: () {
        controller.onTap(productEntity);
      },
      icon: Container(
        height: ResponsiveUtils.height(40),
        width: ResponsiveUtils.width(40),
        decoration: BoxDecoration(
          color: ThemeHelper.getSecondBackground(context),
          shape: BoxShape.circle,
        ),
        child: Obx(
          () => Icon(
            controller.isFavorite.value
                ? Icons.favorite
                : Icons.favorite_outline,
            size: ResponsiveUtils.fontSize(15),
            color: ThemeHelper.getIconColor(context),
          ),
        ),
      ),
    );
  }
}
