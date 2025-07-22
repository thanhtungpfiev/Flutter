import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_cubit.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/widgets/add_to_bag.dart';
import 'package:ecommerce_clone/presentation/product_detail/widgets/product_images_widget.dart';
import 'package:ecommerce_clone/presentation/product_detail/widgets/product_price_widget.dart';
import 'package:ecommerce_clone/presentation/product_detail/widgets/product_quantity_widget.dart';
import 'package:ecommerce_clone/presentation/product_detail/widgets/product_title_widget.dart';
import 'package:ecommerce_clone/presentation/product_detail/widgets/selected_color_widget.dart';
import 'package:ecommerce_clone/presentation/product_detail/widgets/selected_size_widget.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailPage({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ProductQuantityCubit>()),
        BlocProvider(create: (context) => sl<ProductColorSelectionCubit>()),
        BlocProvider(create: (context) => sl<ProductSizeSelectionCubit>()),
        BlocProvider(create: (context) => sl<BasicReactiveButtonCubit>()),
        // BlocProvider(
        //   create:
        //       (context) =>
        //           sl<FavoriteIconCubit>()..isFavorite(productEntity.productId),
        // ),
      ],
      child: Scaffold(
        appBar: BasicAppBar(
          hideBack: false,
          // action: FavoriteButton(productEntity: productEntity),
        ),
        bottomNavigationBar: AddToBagWidget(productEntity: productEntity),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImagesWidget(productEntity: productEntity),
              SizedBox(height: ResponsiveUtils.height(10)),
              ProductTitleWidget(productEntity: productEntity),
              SizedBox(height: ResponsiveUtils.height(10)),
              ProductPriceWidget(productEntity: productEntity),
              SizedBox(height: ResponsiveUtils.height(20)),
              SelectedSizeWidget(productEntity: productEntity),
              SizedBox(height: ResponsiveUtils.height(15)),
              SelectedColorWidget(productEntity: productEntity),
              SizedBox(height: ResponsiveUtils.height(15)),
              ProductQuantityWidget(productEntity: productEntity),
            ],
          ),
        ),
      ),
    );
  }
}
