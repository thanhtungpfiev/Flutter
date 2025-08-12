import 'package:ecommerce_clone_getx/app/common/helper/bottom_sheet/app_bottom_sheet.dart';
import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_color_selection_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/widgets/product_colors_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedColorWidget extends GetView<ProductColorSelectionController> {
  const SelectedColorWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppBottomSheet.display(
          context,
          ProductColorsWidget(productEntity: productEntity),
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
              UIConstants.color,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveUtils.fontSize(14),
              ),
            ),
            Row(
              children: [
                Obx(() {
                  final selected = controller.selectedIndex.value;
                  return Container(
                    height: ResponsiveUtils.height(20),
                    width: ResponsiveUtils.width(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(
                        productEntity.colors[selected].rgb[0],
                        productEntity.colors[selected].rgb[1],
                        productEntity.colors[selected].rgb[2],
                        1,
                      ),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
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
