import 'package:ecommerce_clone/common/helper/bottom_sheet/app_bottom_sheet.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/widgets/product_colors_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedColorWidget extends StatelessWidget {
  const SelectedColorWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppBottomSheet.display(
          context,
          BlocProvider.value(
            value: BlocProvider.of<ProductColorSelectionCubit>(context),
            child: ProductColorsWidget(productEntity: productEntity),
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
              UIConstants.color,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveUtils.fontSize(14),
              ),
            ),
            Row(
              children: [
                BlocBuilder<ProductColorSelectionCubit, int>(
                  builder:
                      (context, state) => Container(
                        height: ResponsiveUtils.height(20),
                        width: ResponsiveUtils.width(20),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(
                            productEntity.colors[state].rgb[0],
                            productEntity.colors[state].rgb[1],
                            productEntity.colors[state].rgb[2],
                            1,
                          ),
                          shape: BoxShape.circle,
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
