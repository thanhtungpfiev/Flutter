import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/order/entities/product_ordered_entity.dart';
import 'package:ecommerce_clone/presentation/cart/bloc/cart_products_display_cubit.dart';
import 'package:ecommerce_clone/presentation/cart/bloc/cart_products_display_state.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(title: Text('Cart')),
      body: BlocProvider(
        create:
            (context) => sl<CartProductsDisplayCubit>()..displayCartProducts(),
        child: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
          builder: (context, state) {
            if (state is CartProductsDisplayLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartProductsDisplayLoadSuccessState) {
              return state.products.isEmpty
                  ? Center(child: _cartIsEmpty())
                  : Stack(
                    children: [
                      _products(state.products),
                      Align(
                        alignment: Alignment.bottomCenter,
                        // child: Checkout(products: state.products),
                      ),
                    ],
                  );
            }
            if (state is LoadCartProductsDisplayLoadErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _products(List<ProductOrderedEntity> products) {
    return ListView.separated(
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      itemBuilder: (context, index) {
        // return ProductOrderedCard(productOrderedEntity: products[index]);
      },
      separatorBuilder:
          (context, index) => SizedBox(height: ResponsiveUtils.height(10)),
      itemCount: products.length,
    );
  }

  Widget _cartIsEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppVectors.cartBag),
        SizedBox(height: ResponsiveUtils.height(20)),
        Text(
          "Cart is empty",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveUtils.fontSize(20),
          ),
        ),
      ],
    );
  }
}
