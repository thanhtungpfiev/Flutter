import 'package:ecommerce_clone_getx/app/common/helper/bottom_sheet/app_bottom_sheet.dart';
import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_size_selection_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/product_sizes_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedSizeWidget extends GetView<ProductSizeSelectionController> {
  const SelectedSizeWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppBottomSheet.display(
          context,
          ProductSizesWidget(productEntity: productEntity),
        );
      },
      child: Container(
        height: ResponsiveUtils.height(60),
        margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
        padding: EdgeInsets.all(ResponsiveUtils.width(12)),
        decoration: BoxDecoration(
          color: ThemeHelper.getSecondBackground(context),
          borderRadius: BorderRadius.circular(ResponsiveUtils.radius(100)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              UIConstants.size,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveUtils.fontSize(14),
              ),
            ),
            Row(
              children: [
                Obx(
                  () => Text(
                    productEntity.sizes[controller.selectedIndex.value],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveUtils.fontSize(18),
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveUtils.width(15)),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: ResponsiveUtils.width(30),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
