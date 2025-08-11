import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      child: TextField(
        readOnly: true,
        style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        onTap: () {
          // AppNavigator.push(context, const SearchPage());
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(ResponsiveUtils.width(12)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveUtils.radius(50)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveUtils.radius(50)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: SvgPicture.asset(
            AppVectors.search,
            fit: BoxFit.none,
            colorFilter: ColorFilter.mode(
              ThemeHelper.getIconColor(context),
              BlendMode.srcIn,
            ),
          ),
          hintText: UIConstants.search,
          hintStyle: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        ),
      ),
    );
  }
}
