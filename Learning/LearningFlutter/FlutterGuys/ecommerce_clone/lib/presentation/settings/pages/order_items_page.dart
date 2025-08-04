import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/order/entities/product_ordered_entity.dart';
import 'package:ecommerce_clone/presentation/settings/widgets/order_item_card_widget.dart';
import 'package:flutter/material.dart';

class OrderItemsPage extends StatelessWidget {
  const OrderItemsPage({required this.products, super.key});

  final List<ProductOrderedEntity> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: Text(UIConstants.orderItems)),
      body: _products(),
    );
  }

  Widget _products() {
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
