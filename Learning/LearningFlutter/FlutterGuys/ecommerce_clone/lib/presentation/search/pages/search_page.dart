import 'package:ecommerce_clone/common/blocs/products/products_display_cubit.dart';
import 'package:ecommerce_clone/common/blocs/products/products_display_state.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/common/widgets/product/product_card_widget.dart';
import 'package:ecommerce_clone/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone/core/constants/service_constants.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone/presentation/search/widgets/search_field_widget.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = sl<ProductsDisplayCubit>(
          instanceName: ServiceConstants.getProductsByTitleUseCaseInstance,
        );
        return cubit;
      },
      child: Scaffold(
        appBar: BasicAppBar(
          height: ResponsiveUtils.height(80),
          title: SearchFieldWidget(),
        ),
        body: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
          builder: (context, state) {
            if (state is ProductsDisplayLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsDisplayLoadSuccessfulState) {
              return state.products.isEmpty
                  ? _notFound()
                  : _products(state.products);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _notFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppVectors.notFound),
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.width(16)),
            child: Text(
              UIConstants.noSearchResults,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveUtils.fontSize(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return GridView.builder(
      itemCount: products.length,
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveUtils.responsive(
          mobile: 2,
          tablet: 4,
          desktop: 6,
        ),
        crossAxisSpacing: ResponsiveUtils.width(10),
        mainAxisSpacing: ResponsiveUtils.width(10),
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ProductCardWidget(productEntity: products[index]);
      },
    );
  }
}
