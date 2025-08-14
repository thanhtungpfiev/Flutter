import 'package:ecommerce_clone_getx/app/common/controllers/button/basic_reactive_button_controller.dart';
import 'package:ecommerce_clone_getx/app/common/helper/product/product_price_helper.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/data/order/models/add_to_cart_req_model.dart';
import 'package:ecommerce_clone_getx/app/domain/order/usecases/add_to_cart_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_color_selection_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_quantity_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/controllers/product_size_selection_controller.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToBagWidget extends StatelessWidget {
  const AddToBagWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    final buttonController = BasicReactiveButtonController();
    final productQuantityController = Get.find<ProductQuantityController>();
    final productColorSelectionController =
        Get.find<ProductColorSelectionController>();
    final productSizeSelectionController =
        Get.find<ProductSizeSelectionController>();
    return Padding(
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      child: BasicReactiveButton(
        controller: buttonController,
        onPressed: () async {
          await buttonController.execute(
            usecase: sl<AddToCartUseCase>(),
            params: AddToCartReqModel(
              productId: productEntity.productId,
              productTitle: productEntity.title,
              productQuantity: productQuantityController.quantity.value,
              productColor: productEntity
                  .colors[productColorSelectionController.selectedIndex.value]
                  .title,
              productSize: productEntity
                  .sizes[productSizeSelectionController.selectedIndex.value],
              productPrice: productEntity.price.toDouble(),
              totalPrice:
                  ProductPriceHelper.provideCurrentPrice(productEntity) *
                  productQuantityController.quantity.value,
              productImage: productEntity.images[0],
              createdDate: DateTime.now().toString(),
            ),
          );
          if (buttonController.state.value == BasicReactiveButtonState.error) {
            var snackbar = SnackBar(
              content: Text(buttonController.errorMessage!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          } else {
            Get.toNamed(Routes.cart);
          }
        },
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              var quantity = productQuantityController.quantity.value;
              var price =
                  ProductPriceHelper.provideCurrentPrice(productEntity) *
                  quantity;
              return Text(
                "\$${price.toString()}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: ResponsiveUtils.fontSize(14),
                ),
              );
            }),
            Text(
              UIConstants.addToBag,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: ResponsiveUtils.fontSize(14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
