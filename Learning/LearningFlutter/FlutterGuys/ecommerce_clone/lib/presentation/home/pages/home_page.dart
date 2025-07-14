import 'package:ecommerce_clone/presentation/home/widgets/categories_widget.dart';
import 'package:ecommerce_clone/presentation/home/widgets/header_widget.dart';
import 'package:ecommerce_clone/presentation/home/widgets/search_field_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(),
            SizedBox(height: 24),
            SearchFieldWidget(),
            SizedBox(height: 24),
            CategoriesWidget(),
            SizedBox(height: 24),
            // TopSelling(),
            // SizedBox(height: 24),
            // NewIn(),
          ],
        ),
      ),
    );
  }
}
