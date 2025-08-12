import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/widgets/categories_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/widgets/header_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/widgets/search_field_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/widgets/top_selling_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HeaderWidget(),
            SizedBox(height: ResponsiveUtils.height(24)),
            const SearchFieldWidget(),
            SizedBox(height: ResponsiveUtils.height(24)),
            const CategoriesWidget(),
            SizedBox(height: ResponsiveUtils.height(24)),
            const TopSellingWidget(),
            SizedBox(height: ResponsiveUtils.height(24)),
            // const NewInWidget(),
          ],
        ),
      ),
    );
  }
}
