import 'dart:ui';

import 'package:ecommerce_clone/common/blocs/products/products_display_cubit.dart';
import 'package:ecommerce_clone/common/blocs/products/products_display_state.dart';
import 'package:ecommerce_clone/common/widgets/product/product_card_widget.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewInWidget extends StatelessWidget {
  const NewInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = sl<ProductsDisplayCubit>(instanceName: 'newIn');
        cubit.displayProducts();
        return cubit;
      },
      child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
        builder: (context, state) {
          if (state is ProductsDisplayLoadingState) {
            return const CircularProgressIndicator();
          }
          if (state is ProductsDisplayLoadSuccessfulState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _newIn(),
                SizedBox(height: ResponsiveUtils.spacing20),
                _products(state.products),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _newIn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.spacing16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'New In',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            fontSize: ResponsiveUtils.font16,
          ),
        ),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return SizedBox(
      height: ResponsiveUtils.responsive(
        mobile: ResponsiveUtils.height(300),
        tablet: ResponsiveUtils.height(350),
        desktop: 300.0,
      ),
      child: Builder(
        builder:
            (context) => ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.spacing16,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ProductCardWidget(productEntity: products[index]);
                },
                separatorBuilder:
                    (context, index) =>
                        SizedBox(width: ResponsiveUtils.spacing10),
                itemCount: products.length,
              ),
            ),
      ),
    );
  }
}
