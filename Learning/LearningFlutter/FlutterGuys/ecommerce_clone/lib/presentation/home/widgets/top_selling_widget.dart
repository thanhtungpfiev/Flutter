import 'dart:ui';

import 'package:ecommerce_clone/common/blocs/products/products_display_cubit.dart';
import 'package:ecommerce_clone/common/blocs/products/products_display_state.dart';
import 'package:ecommerce_clone/common/widgets/product/product_card_widget.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopSellingWidget extends StatelessWidget {
  const TopSellingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsDisplayCubit>(
      create: (context) {
        final cubit = sl<ProductsDisplayCubit>(
          instanceName: 'getTopSellingUseCase',
        );
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
                _topSelling(),
                SizedBox(height: ResponsiveUtils.height(20)),
                _products(state.products),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _topSelling() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Top Selling',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ResponsiveUtils.fontSize(16),
          ),
        ),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return SizedBox(
      height: ResponsiveUtils.height(300),
      child: Builder(
        builder:
            (context) => ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.width(16),
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ProductCardWidget(productEntity: products[index]);
                },
                separatorBuilder:
                    (context, index) =>
                        SizedBox(width: ResponsiveUtils.width(10)),
                itemCount: products.length,
              ),
            ),
      ),
    );
  }
}
