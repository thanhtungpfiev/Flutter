import 'package:ecommerce_clone/common/helper/bottom_sheet/app_bottom_sheet.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/widgets/product_sizes_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedSizeWidget extends StatelessWidget {
  const SelectedSizeWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppBottomSheet.display(
          context,
          BlocProvider.value(
            value: BlocProvider.of<ProductSizeSelectionCubit>(context),
            child: ProductSizesWidget(productEntity: productEntity),
          ),
        );
      },
      child: Container(
        height: ResponsiveUtils.height(60),
        margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
        padding: EdgeInsets.all(ResponsiveUtils.width(12)),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(ResponsiveUtils.radius(100)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveUtils.fontSize(14),
              ),
            ),
            Row(
              children: [
                BlocBuilder<ProductSizeSelectionCubit, int>(
                  builder:
                      (context, state) => Text(
                        productEntity.sizes[state],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ResponsiveUtils.fontSize(18),
                        ),
                      ),
                ),
                SizedBox(width: ResponsiveUtils.width(15)),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: ResponsiveUtils.width(30),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
