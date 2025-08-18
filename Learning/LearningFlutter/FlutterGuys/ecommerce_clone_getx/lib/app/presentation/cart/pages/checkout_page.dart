import 'package:ecommerce_clone_getx/app/common/controllers/button/basic_reactive_button_controller.dart';
import 'package:ecommerce_clone_getx/app/common/helper/cart/cart_helper.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/data/order/models/order_registration_req.dart';
import 'package:ecommerce_clone_getx/app/domain/order/entities/product_ordered_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/order/usecases/order_registration_usecase.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatelessWidget {
  CheckOutPage({super.key});

  final List<ProductOrderedEntity> products =
      Get.arguments[UIConstants.products];
  final TextEditingController _addressCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final buttonController = BasicReactiveButtonController();
    return Scaffold(
      appBar: BasicAppBar(title: Text(UIConstants.checkout)),
      body: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.width(16)),
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _addressField(context),
                BasicReactiveButton(
                  controller: buttonController,
                  content: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.width(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${CartHelper.calculateCartSubtotal(products)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ResponsiveUtils.fontSize(16),
                          ),
                        ),
                        Text(
                          UIConstants.placeOrder,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: ResponsiveUtils.fontSize(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    await buttonController.execute(
                      usecase: sl<OrderRegistrationUseCase>(),
                      params: OrderRegistrationReqModel(
                        products: products,
                        createdDate: DateTime.now().toString(),
                        itemCount: products.length,
                        totalPrice: CartHelper.calculateCartSubtotal(products),
                        shippingAddress: _addressCon.text,
                      ),
                    );
                    if (buttonController.state.value ==
                        BasicReactiveButtonState.success) {
                      Get.offNamedUntil(Routes.orderPlaced, (route) => false);
                    }
                    if (buttonController.state.value ==
                        BasicReactiveButtonState.error) {
                      var snackbar = SnackBar(
                        content: Text(buttonController.errorMessage!),
                        behavior: SnackBarBehavior.floating,
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _addressField(BuildContext context) {
    return TextField(
      controller: _addressCon,
      minLines: 2,
      maxLines: 4,
      decoration: InputDecoration(hintText: UIConstants.shippingAddress),
    );
  }
}
