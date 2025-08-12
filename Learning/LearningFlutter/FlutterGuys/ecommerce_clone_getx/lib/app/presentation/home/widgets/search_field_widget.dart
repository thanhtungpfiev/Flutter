import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/search_field/common_search_field_widget.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSearchFieldWidget(
      readOnly: true,
      horizontalPadding: 16,
      onTap: () {
        Get.toNamed(Routes.search);
      },
      hintStyle: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
    );
  }
}
