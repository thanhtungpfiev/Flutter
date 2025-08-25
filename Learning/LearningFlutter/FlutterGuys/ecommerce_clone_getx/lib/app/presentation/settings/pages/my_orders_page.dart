import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/order/entities/order_entity.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/controllers/orders_display_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersPage extends GetView<OrdersDisplayController> {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: Text(UIConstants.myOrders)),
      body: Obx(() {
        if (controller.state.value == OrdersDisplayState.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.state.value == OrdersDisplayState.success) {
          return _orders(controller.orders);
        }
        if (controller.state.value == OrdersDisplayState.error) {
          return Center(child: Text(controller.errorMessage.value));
        }
        return Container();
      }),
    );
  }

  Widget _orders(List<OrderEntity> orders) {
    return ListView.separated(
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.orderDetail,
              arguments: {UIConstants.orderEntity: orders[index]},
            );
          },
          child: Container(
            height: ResponsiveUtils.height(70),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.width(16),
            ),
            decoration: BoxDecoration(
              color: ThemeHelper.getSecondBackground(context),
              borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_rounded),
                    SizedBox(width: ResponsiveUtils.width(20)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${UIConstants.orderNumber}${orders[index].code}',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: ResponsiveUtils.fontSize(16),
                          ),
                        ),
                        Text(
                          '${orders[index].products.length} ${orders[index].products.length == 1 ? UIConstants.item : UIConstants.items}',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: ResponsiveUtils.fontSize(12),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: ResponsiveUtils.height(20)),
      itemCount: orders.length,
    );
  }
}
