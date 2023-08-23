import 'package:flutter/material.dart';

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyCustomAppBar({
    super.key,
    this.onTap,
    required this.child,
  });

  final Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: GestureDetector(
        onTap: onTap,
        child: child,
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/Me_avatar.jpg'),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
