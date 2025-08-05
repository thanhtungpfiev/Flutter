import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({
    super.key,
    this.title,
    this.action,
    this.backgroundColor,
    this.hideBack = false,
    this.height,
  });

  final Widget? title;
  final Widget? action;
  final Color? backgroundColor;
  final bool hideBack;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title ?? const Text(''),
      actions: [action ?? Container()],
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: height ?? ResponsiveUtils.height(80),
      titleSpacing: 0,
      leading: hideBack
          ? null
          : IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Container(
                height: ResponsiveUtils.height(50),
                width: ResponsiveUtils.width(50),
                decoration: BoxDecoration(
                  color: ThemeHelper.getSecondBackground(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: ResponsiveUtils.fontSize(16),
                  color: ThemeHelper.getThemeIconColor(context),
                ),
              ),
            ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? ResponsiveUtils.height(80));
}
