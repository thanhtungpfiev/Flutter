import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/order/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderEntity orderEntity = Get.arguments[UIConstants.orderEntity];
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('${UIConstants.orderNumber}${orderEntity.code}'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveUtils.width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _status(orderEntity),
            SizedBox(height: ResponsiveUtils.height(50)),
            _items(context, orderEntity),
            SizedBox(height: ResponsiveUtils.height(30)),
            _shipping(context, orderEntity),
          ],
        ),
      ),
    );
  }

  Widget _status(OrderEntity orderEntity) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: ResponsiveUtils.height(30),
                  width: ResponsiveUtils.width(30),
                  decoration: BoxDecoration(
                    color: orderEntity.orderStatus[index].done
                        ? AppColors.primary
                        : ThemeHelper.getThemeIconColor(context),
                    shape: BoxShape.circle,
                  ),
                  child: orderEntity.orderStatus[index].done
                      ? const Icon(Icons.check)
                      : Container(),
                ),
                SizedBox(width: ResponsiveUtils.width(15)),
                Text(
                  orderEntity.orderStatus[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ResponsiveUtils.fontSize(16),
                    color: orderEntity.orderStatus[index].done
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            Text(
              orderEntity.orderStatus[index].createdDate
                  .toDate()
                  .toString()
                  .split(' ')[0],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveUtils.fontSize(14),
                color: orderEntity.orderStatus[index].done
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: ResponsiveUtils.height(50)),
      reverse: true,
      itemCount: orderEntity.orderStatus.length,
    );
  }

  Widget _items(BuildContext context, OrderEntity orderEntity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          UIConstants.orderItems,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveUtils.fontSize(16),
          ),
        ),
        SizedBox(height: ResponsiveUtils.height(15)),
        GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.orderItems,
              arguments: {UIConstants.products: orderEntity.products},
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
                    Icon(Icons.receipt_rounded),
                    SizedBox(width: ResponsiveUtils.width(20)),
                    Text(
                      '${orderEntity.products.length} ${orderEntity.products.length == 1 ? UIConstants.item : UIConstants.items}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: ResponsiveUtils.fontSize(16),
                      ),
                    ),
                  ],
                ),
                Text(
                  UIConstants.viewAll,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ResponsiveUtils.fontSize(14),
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _shipping(BuildContext context, OrderEntity orderEntity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          UIConstants.shippingDetails,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveUtils.fontSize(16),
          ),
        ),
        SizedBox(height: ResponsiveUtils.height(15)),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(ResponsiveUtils.width(16)),
          decoration: BoxDecoration(
            color: ThemeHelper.getSecondBackground(context),
            borderRadius: BorderRadius.circular(ResponsiveUtils.radius(10)),
          ),
          child: Text(orderEntity.shippingAddress),
        ),
      ],
    );
  }
}
