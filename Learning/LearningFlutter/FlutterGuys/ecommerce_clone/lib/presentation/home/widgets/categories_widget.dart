import 'dart:ui';

import 'package:ecommerce_clone/common/blocs/categories/categories_display_cubit.dart';
import 'package:ecommerce_clone/common/blocs/categories/categories_display_state.dart';
import 'package:ecommerce_clone/common/helper/images/image_display_helper.dart';
import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/category/entities/category_entity.dart';
import 'package:ecommerce_clone/presentation/all_categories/pages/all_categories_page.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CategoriesDisplayCubit>()..displayCategories(),
      child: BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
        builder: (context, state) {
          if (state is CategoriesDisplayLoadingState) {
            return const CircularProgressIndicator();
          }
          if (state is CategoriesDisplayLoadSuccessState) {
            return Column(
              children: [
                _seaAll(context),
                SizedBox(height: ResponsiveUtils.height(20)),
                _categories(state.categories),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _seaAll(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveUtils.fontSize(16),
            ),
          ),
          GestureDetector(
            onTap: () {
              AppNavigator.push(context, const AllCategoriesPage());
            },
            child: Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: ResponsiveUtils.fontSize(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categories(List<CategoryEntity> categories) {
    return SizedBox(
      height: ResponsiveUtils.height(100),
      child: Builder(
        builder:
            (context) => ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.width(16),
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: ResponsiveUtils.height(60),
                        width: ResponsiveUtils.width(60),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image:
                              categories[index].image.isNotEmpty
                                  ? DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      ImageDisplayHelper.generateCategoryImageURL(
                                        categories[index].image,
                                      ),
                                    ),
                                  )
                                  : null,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.height(8)),
                      Text(
                        categories[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ResponsiveUtils.fontSize(14),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder:
                    (context, index) =>
                        SizedBox(width: ResponsiveUtils.width(15)),
                itemCount: categories.length,
              ),
            ),
      ),
    );
  }
}
