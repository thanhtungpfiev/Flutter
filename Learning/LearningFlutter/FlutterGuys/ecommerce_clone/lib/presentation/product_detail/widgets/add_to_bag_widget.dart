import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_cubit.dart';
import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_state.dart';
import 'package:ecommerce_clone/common/helper/product/product_price_helper.dart';
import 'package:ecommerce_clone/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/data/order/models/add_to_cart_req_model.dart';
import 'package:ecommerce_clone/domain/order/usecases/add_to_cart_usecase.dart';
import 'package:ecommerce_clone/domain/product/entities/product_entity.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToBagWidget extends StatelessWidget {
  const AddToBagWidget({required this.productEntity, super.key});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BasicReactiveButtonCubit, BasicReactiveButtonState>(
      listener: (context, state) {
        if (state is BasicReactiveButtonLoadSuccessState) {
          // AppNavigator.push(context, const CartPage());
        }
        if (state is BasicReactiveButtonLoadErrorState) {
          var snackbar = SnackBar(
            content: Text(state.errorMessage),
            behavior: SnackBarBehavior.floating,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.width(16)),
        child: BasicReactiveButton(
          onPressed: () {
            context.read<BasicReactiveButtonCubit>().execute(
              usecase: sl<AddToCartUseCase>(),
              params: AddToCartReqModel(
                productId: productEntity.productId,
                productTitle: productEntity.title,
                productQuantity: context.read<ProductQuantityCubit>().state,
                productColor:
                    productEntity
                        .colors[context
                            .read<ProductColorSelectionCubit>()
                            .selectedIndex]
                        .title,
                productSize:
                    productEntity.sizes[context
                        .read<ProductSizeSelectionCubit>()
                        .selectedIndex],
                productPrice: productEntity.price.toDouble(),
                totalPrice:
                    ProductPriceHelper.provideCurrentPrice(productEntity) *
                    context.read<ProductQuantityCubit>().state,
                productImage: productEntity.images[0],
                createdDate: DateTime.now().toString(),
              ),
            );
          },
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<ProductQuantityCubit, int>(
                builder: (context, state) {
                  var price =
                      ProductPriceHelper.provideCurrentPrice(productEntity) *
                      state;
                  return Text(
                    "\$${price.toString()}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: ResponsiveUtils.fontSize(14),
                    ),
                  );
                },
              ),
              Text(
                'Add to Bag',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: ResponsiveUtils.fontSize(14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
