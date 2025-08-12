import 'package:ecommerce_clone/common/blocs/products/products_display_cubit.dart';
import 'package:ecommerce_clone/common/widgets/search_field/common_search_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFieldWidget extends StatelessWidget {
  SearchFieldWidget({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CommonSearchFieldWidget(
      controller: textEditingController,
      horizontalPadding: 8,
      onChanged: (value) {
        if (value.isEmpty) {
          context.read<ProductsDisplayCubit>().displayInitial();
        } else {
          context.read<ProductsDisplayCubit>().displayProducts(params: value);
        }
      },
    );
  }
}
