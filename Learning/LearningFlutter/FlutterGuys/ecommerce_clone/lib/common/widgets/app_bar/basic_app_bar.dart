import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
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
      toolbarHeight: height ?? 80,
      titleSpacing: 0,
      leading:
          hideBack
              ? null
              : IconButton(
                onPressed: () {
                  AppNavigator.pop(context);
                },
                icon: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: AppColors.secondBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 80);
}
