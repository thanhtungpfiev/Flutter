import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/presentation/cart/bloc/cart_products_display_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends GetView<CartProductsDisplayController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text(UIConstants.cart)),
      // body: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
      //   builder: (context, state) {
      //     if (state is CartProductsDisplayLoadingState) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     if (state is CartProductsDisplayLoadSuccessState) {
      //       return state.products.isEmpty
      //           ? Center(child: _cartIsEmpty())
      //           : Stack(
      //               children: [
      //                 _products(state.products),
      //                 Align(
      //                   alignment: Alignment.bottomCenter,
      //                   child: CheckoutWidget(products: state.products),
      //                 ),
      //               ],
      //             );
      //     }
      //     if (state is LoadCartProductsDisplayLoadErrorState) {
      //       return Center(child: Text(state.errorMessage));
      //     }
      //     return Container();
      //   },
      // ),
    );
  }

  // Widget _products(List<ProductOrderedEntity> products) {
  //   return ListView.separated(
  //     padding: EdgeInsets.all(ResponsiveUtils.width(16)),
  //     itemBuilder: (context, index) {
  //       return ProductOrderedCardWidget(productOrderedEntity: products[index]);
  //     },
  //     separatorBuilder: (context, index) =>
  //         SizedBox(height: ResponsiveUtils.height(10)),
  //     itemCount: products.length,
  //   );
  // }

  // Widget _cartIsEmpty() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       SvgPicture.asset(AppVectors.cartBag),
  //       SizedBox(height: ResponsiveUtils.height(20)),
  //       Text(
  //         UIConstants.cartIsEmpty,
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           fontWeight: FontWeight.w500,
  //           fontSize: ResponsiveUtils.fontSize(20),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
