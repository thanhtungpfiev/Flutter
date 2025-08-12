import 'dart:ui';

import 'package:ecommerce_clone_getx/app/common/controllers/categories/categories_display_controller.dart';
import 'package:ecommerce_clone_getx/app/common/helper/images/image_display_helper.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/category/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesWidget extends GetView<CategoriesDisplayController> {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.status.value == CategoriesDisplayStatus.loading) {
        return const CircularProgressIndicator();
      }
      if (controller.status.value == CategoriesDisplayStatus.success) {
        return Column(
          children: [
            _seaAll(context),
            SizedBox(height: ResponsiveUtils.height(20)),
            _categories(controller.categories),
          ],
        );
      }
      return Container();
    });
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
              Get.toNamed(Routes.allCategories);
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
        builder: (context) => ScrollConfiguration(
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
                      image: categories[index].image.isNotEmpty
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
            separatorBuilder: (context, index) =>
                SizedBox(width: ResponsiveUtils.width(15)),
            itemCount: categories.length,
          ),
        ),
      ),
    );
  }
}
