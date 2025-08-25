import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/order/entities/product_ordered_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/widgets/order_item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderItemsPage extends StatelessWidget {
  const OrderItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: Text(UIConstants.orderItems)),
      body: _products(),
    );
  }

  Widget _products() {
    final List<ProductOrderedEntity> products =
        Get.arguments[UIConstants.products];
    return ListView.separated(
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      itemBuilder: (context, index) {
        return OrderItemCardWidget(productOrderedEntity: products[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: products.length,
    );
  }
}
