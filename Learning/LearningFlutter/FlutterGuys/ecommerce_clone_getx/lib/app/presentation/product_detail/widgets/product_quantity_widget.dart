import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_quantity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductQuantityWidget extends GetView<ProductQuantityController> {
  const ProductQuantityWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveUtils.height(60),
      margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      padding: EdgeInsets.only(left: ResponsiveUtils.width(12)),
      decoration: BoxDecoration(
        color: ThemeHelper.getSecondBackground(context),
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            UIConstants.quantity,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveUtils.fontSize(14),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  controller.decrement();
                },
                icon: Container(
                  height: ResponsiveUtils.height(40),
                  width: ResponsiveUtils.width(40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Center(
                    child: Icon(Icons.remove, size: ResponsiveUtils.width(30)),
                  ),
                ),
              ),
              SizedBox(width: ResponsiveUtils.width(10)),
              Obx(
                () => Text(
                  controller.quantity.value.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveUtils.fontSize(18),
                  ),
                ),
              ),
              SizedBox(width: ResponsiveUtils.width(10)),
              IconButton(
                onPressed: () {
                  controller.increment();
                },
                icon: Container(
                  height: ResponsiveUtils.height(40),
                  width: ResponsiveUtils.width(40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Center(
                    child: Icon(Icons.add, size: ResponsiveUtils.width(30)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
