import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/widgets/search_field/common_search_field_widget.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/presentation/search/pages/search_page.dart';
import 'package:flutter/material.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonSearchFieldWidget(
      readOnly: true,
      horizontalPadding: 16,
      onTap: () {
        AppNavigator.push(context, const SearchPage());
      },
      hintStyle: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
    );
  }
}
