import 'package:ecommerce_clone/common/blocs/categories/categories_display_cubit.dart';
import 'package:ecommerce_clone/common/blocs/categories/categories_display_state.dart';
import 'package:ecommerce_clone/common/helper/images/image_display_helper.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
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
          padding: EdgeInsets.all(ResponsiveUtils.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shopByCategories(),
              SizedBox(height: ResponsiveUtils.spacing10),
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
        fontSize: ResponsiveUtils.font22,
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
                  // AppNavigator.push(
                  //   context,
                  //   CategoryProductsPage(
                  //     categoryEntity: state.categories[index],
                  //   ),
                  // );
                },
                child: Container(
                  height: ResponsiveUtils.responsive(
                    mobile: ResponsiveUtils.height(70),
                    tablet: ResponsiveUtils.height(70),
                    desktop: 70,
                  ),
                  padding: EdgeInsets.all(ResponsiveUtils.spacing12),
                  decoration: BoxDecoration(
                    color: AppColors.secondBackground,
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.radius8,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: ResponsiveUtils.height(50),
                        width: ResponsiveUtils.responsive(
                          mobile: ResponsiveUtils.width(50),
                          tablet: ResponsiveUtils.width(50),
                          desktop: 50,
                        ),
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
                      SizedBox(width: ResponsiveUtils.spacing15),
                      Text(
                        state.categories[index].title,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.font16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder:
                (context, index) => SizedBox(height: ResponsiveUtils.spacing10),
            itemCount: state.categories.length,
          );
        }
        return Container();
      },
    );
  }
}
