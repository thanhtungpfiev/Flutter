import 'package:ecommerce_clone_getx/app/common/controllers/products/products_display_controller.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/search_field/common_search_field_widget.dart';
import 'package:ecommerce_clone_getx/app/core/constants/service_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFieldWidget extends GetView<ProductsDisplayController> {
  SearchFieldWidget({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  ProductsDisplayController get controller =>
      Get.find<ProductsDisplayController>(
        tag: ServiceConstants.getProductsByTitleUseCaseInstance,
      );

  @override
  Widget build(BuildContext context) {
    return CommonSearchFieldWidget(
      controller: textEditingController,
      horizontalPadding: 8,
      onChanged: (value) {
        if (value.isEmpty) {
          controller.displayInitial();
        } else {
          controller.displayProducts(params: value);
        }
      },
    );
  }
}
