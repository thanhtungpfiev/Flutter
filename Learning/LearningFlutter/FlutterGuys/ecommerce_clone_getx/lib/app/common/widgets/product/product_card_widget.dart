import 'package:ecommerce_clone_getx/app/common/helper/images/image_display_helper.dart';
import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    required this.productEntity,
    this.onReturn,
    super.key,
  });

  final ProductEntity productEntity;
  final VoidCallback? onReturn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(
          Routes.productDetail,
          arguments: {UIConstants.productEntity: productEntity},
        );
        // Call the callback when returning from product detail
        onReturn?.call();
      },
      child: Container(
        width: ResponsiveUtils.width(180),
        decoration: BoxDecoration(
          color: ThemeHelper.getSecondBackground(context),
          borderRadius: BorderRadius.circular(ResponsiveUtils.radius(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      ImageDisplayHelper.generateProductImageURL(
                        productEntity.images[0],
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ResponsiveUtils.radius(8)),
                    topRight: Radius.circular(ResponsiveUtils.radius(8)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(ResponsiveUtils.width(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productEntity.title,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.fontSize(12),
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          productEntity.discountedPrice == 0
                              ? "${productEntity.price.toStringAsFixed(2)}\$"
                              : "${productEntity.discountedPrice.toStringAsFixed(2)}\$",
                          style: TextStyle(
                            fontSize: ResponsiveUtils.fontSize(12),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.width(10)),
                        Text(
                          productEntity.discountedPrice == 0
                              ? ''
                              : "${productEntity.price.toStringAsFixed(2)}\$",
                          style: TextStyle(
                            fontSize: ResponsiveUtils.fontSize(12),
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
