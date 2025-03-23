// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:netflix/core/configs/theme/app_colors.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppbar({
    super.key,
    this.title,
    this.action,
    this.leading,
    this.backgroundColor,
    required this.hideBack,
    this.height,
  });

  final Widget? title;
  final Widget? action;
  final Widget? leading;
  final Color? backgroundColor;
  final bool hideBack;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: height ?? 80,
      title: title ?? const Text(''),
      titleSpacing: 0,
      leadingWidth: leading != null ? 150 : null,
      actions: [action ?? Container()],
      leading:
          leading ??
          (hideBack
              ? null
              : IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.secondBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 80);
}
