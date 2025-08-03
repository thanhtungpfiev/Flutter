import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_cubit.dart';
import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_state.dart';
import 'package:ecommerce_clone/common/helper/cart/cart_helper.dart';
import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/data/order/models/order_registration_req.dart';
import 'package:ecommerce_clone/domain/order/entities/product_ordered_entity.dart';
import 'package:ecommerce_clone/domain/order/usecases/order_registration_usecase.dart';
import 'package:ecommerce_clone/presentation/cart/pages/order_placed_page.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutPage extends StatelessWidget {
  CheckOutPage({required this.products, super.key});

  final List<ProductOrderedEntity> products;
  final TextEditingController _addressCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text(UIConstants.checkout)),
      body: BlocProvider(
        create: (context) => sl<BasicReactiveButtonCubit>(),
        child: BlocListener<BasicReactiveButtonCubit, BasicReactiveButtonState>(
          listener: (context, state) {
            if (state is BasicReactiveButtonLoadSuccessState) {
              AppNavigator.pushAndRemoveUntil(context, const OrderPlacedPage());
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
            child: Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _addressField(context),
                    BasicReactiveButton(
                      content: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.width(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${CartHelper.calculateCartSubtotal(products)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ResponsiveUtils.fontSize(16),
                              ),
                            ),
                            Text(
                              UIConstants.placeOrder,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: ResponsiveUtils.fontSize(16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        context.read<BasicReactiveButtonCubit>().execute(
                          usecase: sl<OrderRegistrationUseCase>(),
                          params: OrderRegistrationReqModel(
                            products: products,
                            createdDate: DateTime.now().toString(),
                            itemCount: products.length,
                            totalPrice: CartHelper.calculateCartSubtotal(
                              products,
                            ),
                            shippingAddress: _addressCon.text,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _addressField(BuildContext context) {
    return TextField(
      controller: _addressCon,
      minLines: 2,
      maxLines: 4,
      decoration: InputDecoration(hintText: UIConstants.shippingAddress),
    );
  }
}
