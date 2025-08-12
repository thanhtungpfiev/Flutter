import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductTitleWidget extends StatelessWidget {
  const ProductTitleWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      child: Text(
        productEntity.title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ResponsiveUtils.fontSize(16),
        ),
      ),
    );
  }
}
