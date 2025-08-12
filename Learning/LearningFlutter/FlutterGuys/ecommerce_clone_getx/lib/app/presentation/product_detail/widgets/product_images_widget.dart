import 'package:ecommerce_clone_getx/app/common/helper/images/image_display_helper.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductImagesWidget extends StatelessWidget {
  const ProductImagesWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveUtils.height(300),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: ResponsiveUtils.width(200),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  ImageDisplayHelper.generateProductImageURL(
                    productEntity.images[index],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) =>
            SizedBox(width: ResponsiveUtils.width(10)),
        itemCount: productEntity.images.length,
      ),
    );
  }
}
