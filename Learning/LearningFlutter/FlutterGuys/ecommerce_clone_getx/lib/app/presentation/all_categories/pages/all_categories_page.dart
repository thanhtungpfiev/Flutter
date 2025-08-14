import 'package:ecommerce_clone_getx/app/common/controllers/categories/categories_display_controller.dart';
import 'package:ecommerce_clone_getx/app/common/helper/images/image_display_helper.dart';
import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoriesPage extends GetView<CategoriesDisplayController> {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(hideBack: false),
      body: Padding(
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
    if (controller.state.value == CategoriesDisplayState.loading) {
      return const CircularProgressIndicator();
    }
    if (controller.state.value == CategoriesDisplayState.success) {
      return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                Routes.categoryProducts,
                arguments: {
                  UIConstants.categoryEntity: controller.categories[index],
                },
              );
            },
            child: Container(
              height: ResponsiveUtils.height(70),
              padding: EdgeInsets.all(ResponsiveUtils.width(12)),
              decoration: BoxDecoration(
                color: ThemeHelper.getSecondBackground(context),
                borderRadius: BorderRadius.circular(ResponsiveUtils.radius(8)),
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
                            controller.categories[index].image,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.width(15)),
                  Text(
                    controller.categories[index].title,
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
        separatorBuilder: (context, index) =>
            SizedBox(height: ResponsiveUtils.height(10)),
        itemCount: controller.categories.length,
      );
    }
    return Container();
  }
}
