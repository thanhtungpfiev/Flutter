import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

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
      leading:
          hideBack
              ? null
              : IconButton(
                onPressed: () {
                  AppNavigator.pop(context);
                },
                icon: Container(
                  height: ResponsiveUtils.height(50),
                  width: ResponsiveUtils.width(50),
                  decoration: const BoxDecoration(
                    color: AppColors.secondBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: ResponsiveUtils.fontSize(16),
                    color: Colors.white,
                  ),
                ),
              ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? ResponsiveUtils.height(80));
}
