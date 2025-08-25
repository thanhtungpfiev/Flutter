import 'package:ecommerce_clone_getx/app/common/helper/images/image_display_helper.dart';
import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/order/entities/product_ordered_entity.dart';
import 'package:flutter/material.dart';

class OrderItemCardWidget extends StatelessWidget {
  final ProductOrderedEntity productOrderedEntity;
  const OrderItemCardWidget({required this.productOrderedEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ResponsiveUtils.isDesktop
          ? ResponsiveUtils.height(200)
          : ResponsiveUtils.height(100),
      padding: EdgeInsets.all(ResponsiveUtils.width(8)),
      decoration: BoxDecoration(
        color: ThemeHelper.getSecondBackground(context),
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: ResponsiveUtils.responsive(mobile: 4, tablet: 4, desktop: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: ResponsiveUtils.responsive(
                    mobile: 3,
                    tablet: 3,
                    desktop: 1,
                  ),
                  child: Container(
                    width: ResponsiveUtils.width(90),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          ImageDisplayHelper.generateProductImageURL(
                            productOrderedEntity.productImage,
                          ),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(
                        ResponsiveUtils.radius(4),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveUtils.width(10)),
                Expanded(
                  flex: ResponsiveUtils.responsive(
                    mobile: 6,
                    tablet: 6,
                    desktop: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productOrderedEntity.productTitle,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: ResponsiveUtils.fontSize(16),
                        ),
                      ),
                      Row(
                        children: [
                          Text.rich(
                            overflow: TextOverflow.ellipsis,
                            TextSpan(
                              text: '${UIConstants.size} - ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: ResponsiveUtils.isDesktop
                                    ? ResponsiveUtils.fontSize(14)
                                    : ResponsiveUtils.fontSize(10),
                              ),
                              children: [
                                TextSpan(
                                  text: productOrderedEntity.productSize,
                                  style: TextStyle(
                                    color: ThemeHelper.getThemeIconColor(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ResponsiveUtils.isDesktop
                                        ? ResponsiveUtils.fontSize(14)
                                        : ResponsiveUtils.fontSize(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: ResponsiveUtils.width(10)),
                          Text.rich(
                            overflow: TextOverflow.ellipsis,
                            TextSpan(
                              text: '${UIConstants.color} - ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: ResponsiveUtils.isDesktop
                                    ? ResponsiveUtils.fontSize(14)
                                    : ResponsiveUtils.fontSize(10),
                              ),
                              children: [
                                TextSpan(
                                  text: productOrderedEntity.productColor,
                                  style: TextStyle(
                                    color: ThemeHelper.getThemeIconColor(
                                      context,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ResponsiveUtils.isDesktop
                                        ? ResponsiveUtils.fontSize(14)
                                        : ResponsiveUtils.fontSize(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${productOrderedEntity.totalPrice}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: ResponsiveUtils.fontSize(14),
            ),
          ),
        ],
      ),
    );
  }
}
