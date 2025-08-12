import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_color_selection_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductColorsWidget extends GetView<ProductColorSelectionController> {
  const ProductColorsWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveUtils.screenHeight / 2,
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(ResponsiveUtils.radius(16)),
          topLeft: Radius.circular(ResponsiveUtils.radius(16)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: ResponsiveUtils.height(40),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    UIConstants.color,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ResponsiveUtils.fontSize(22),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveUtils.height(20)),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.itemSelection(index);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: ResponsiveUtils.height(60),
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.width(16),
                    ),
                    decoration: BoxDecoration(
                      color: controller.selectedIndex.value == index
                          ? AppColors.primary
                          : ThemeHelper.getSecondBackground(context),
                      borderRadius: BorderRadius.circular(
                        ResponsiveUtils.radius(50),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productEntity.colors[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveUtils.fontSize(16),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: ResponsiveUtils.height(20),
                              width: ResponsiveUtils.width(20),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(
                                  productEntity.colors[index].rgb[0],
                                  productEntity.colors[index].rgb[1],
                                  productEntity.colors[index].rgb[2],
                                  1,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: ResponsiveUtils.width(15)),
                            controller.selectedIndex.value == index
                                ? Icon(
                                    Icons.check,
                                    size: ResponsiveUtils.width(30),
                                  )
                                : Container(width: ResponsiveUtils.width(30)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: ResponsiveUtils.height(20)),
              itemCount: productEntity.colors.length,
            ),
          ),
        ],
      ),
    );
  }
}
