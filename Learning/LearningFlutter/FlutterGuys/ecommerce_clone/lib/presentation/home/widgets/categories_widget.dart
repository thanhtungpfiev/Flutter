import 'package:ecommerce_clone/common/blocs/categories/categories_display_cubit.dart';
import 'package:ecommerce_clone/common/blocs/categories/categories_display_state.dart';
import 'package:ecommerce_clone/common/helper/images/image_display_helper.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/category/entities/category_entity.dart';
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
                SizedBox(height: ResponsiveUtils.spacing20),
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
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.spacing16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveUtils.font16,
            ),
          ),
          GestureDetector(
            onTap: () {
              // AppNavigator.push(context, const AllCategoriesPage());
            },
            child: Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: ResponsiveUtils.font16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categories(List<CategoryEntity> categories) {
    // Responsive sizes: larger on mobile, smaller on desktop
    final double iconSize = ResponsiveUtils.responsive(
      mobile: 70.0,
      tablet: 60.0,
      desktop: 50.0,
    );

    final double containerWidth = ResponsiveUtils.responsive(
      mobile: 85.0,
      tablet: 75.0,
      desktop: 70.0,
    );

    return SizedBox(
      height: ResponsiveUtils.responsive(
        mobile: ResponsiveUtils.height(115),
        tablet: ResponsiveUtils.height(105),
        desktop: 100.0,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.spacing16),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: iconSize,
                width: iconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      ImageDisplayHelper.generateCategoryImageURL(
                        categories[index].image,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: ResponsiveUtils.spacing8),
              SizedBox(
                width: containerWidth,
                child: Text(
                  categories[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ResponsiveUtils.font12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
        separatorBuilder:
            (context, index) => SizedBox(width: ResponsiveUtils.spacing12),
        itemCount: categories.length,
      ),
    );
  }
}
