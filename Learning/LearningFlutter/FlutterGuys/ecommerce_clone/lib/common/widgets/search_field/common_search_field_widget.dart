import 'package:ecommerce_clone/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonSearchFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final double horizontalPadding;
  final TextStyle? hintStyle;

  const CommonSearchFieldWidget({
    super.key,
    this.controller,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.horizontalPadding = 16,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.width(horizontalPadding),
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        onTap: onTap,
        onChanged: onChanged,
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
          hintStyle:
              hintStyle ?? TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        ),
      ),
    );
  }
}
