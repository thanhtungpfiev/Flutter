import 'package:ecommerce_clone/common/blocs/categories/categories_display_cubit.dart';
import 'package:ecommerce_clone/common/blocs/categories/categories_display_state.dart';
import 'package:ecommerce_clone/common/helper/images/image_display_helper.dart';
import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/presentation/category_products/pages/category_products_page.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(hideBack: false),
      body: BlocProvider(
        create: (context) => sl<CategoriesDisplayCubit>()..displayCategories(),
        child: Padding(
          padding: EdgeInsets.all(ResponsiveUtils.width(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shopByCategories(),
              SizedBox(height: ResponsiveUtils.height(10)),
              _categories(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopByCategories() {
    return Text(
      'Shop by Categories',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: ResponsiveUtils.fontSize(22),
      ),
    );
  }

  Widget _categories() {
    return BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
      builder: (context, state) {
        if (state is CategoriesDisplayLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CategoriesDisplayLoadSuccessState) {
          return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AppNavigator.push(
                    context,
                    CategoryProductsPage(
                      categoryEntity: state.categories[index],
                    ),
                  );
                },
                child: Container(
                  height: ResponsiveUtils.height(70),
                  padding: EdgeInsets.all(ResponsiveUtils.width(12)),
                  decoration: BoxDecoration(
                    color: AppColors.secondBackground,
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.radius(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: ResponsiveUtils.height(50),
                        width: ResponsiveUtils.width(50),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              ImageDisplayHelper.generateCategoryImageURL(
                                state.categories[index].image,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ResponsiveUtils.width(15)),
                      Text(
                        state.categories[index].title,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.fontSize(16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder:
                (context, index) =>
                    SizedBox(height: ResponsiveUtils.height(10)),
            itemCount: state.categories.length,
          );
        }
        return Container();
      },
    );
  }
}
