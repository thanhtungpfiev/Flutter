import 'package:ecommerce_clone/common/blocs/products/products_display_cubit.dart';
import 'package:ecommerce_clone/common/blocs/products/products_display_state.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone/domain/product/usecases/get_top_selling_usecase.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopSellingWidget extends StatelessWidget {
  const TopSellingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProductsDisplayCubit(useCase: sl<GetTopSellingUseCase>())
                ..displayProducts(),
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

  Widget _topSelling() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.spacing16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Top Selling',
          style: TextStyle(
            fontWeight: FontWeight.bold,
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
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.spacing16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // return ProductCard(productEntity: products[index]);
          return Container(); // Placeholder until ProductCard is implemented
        },
        separatorBuilder:
            (context, index) => SizedBox(width: ResponsiveUtils.spacing8),
        itemCount: products.length,
      ),
    );
  }
}
