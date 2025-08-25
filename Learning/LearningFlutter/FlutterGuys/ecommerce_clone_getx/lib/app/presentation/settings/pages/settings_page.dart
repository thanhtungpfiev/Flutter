import 'package:ecommerce_clone_getx/app/common/controllers/button/basic_reactive_button_controller.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/signout_usecase.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/widgets/my_favorites_tile_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/widgets/my_orders_tile_widget.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/widgets/theme_tile_widget.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text(UIConstants.settings)),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ResponsiveUtils.width(16)),
              child: Column(
                children: [
                  ThemeTileWidget(),
                  SizedBox(height: ResponsiveUtils.height(15)),
                  MyFavoritesTileWidget(),
                  SizedBox(height: ResponsiveUtils.height(15)),
                  MyOrdersTileWidget(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.width(16)),
            child: BasicReactiveButton(
              controller: BasicReactiveButtonController(),
              onPressed: () async {
                final shouldSignOut = await showSignOutDialog(context);
                if (shouldSignOut == true && context.mounted) {
                  final controller = BasicReactiveButtonController();
                  try {
                    await controller.execute(usecase: sl<SignOutUseCase>());
                    Get.offNamedUntil(Routes.signin, (route) => false);
                  } catch (e) {
                    Get.snackbar(
                      UIConstants.errorSigningOut,
                      e.toString(),
                      backgroundColor: Colors.red,
                    );
                  }
                }
              },
              title: UIConstants.signOut,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showSignOutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(UIConstants.signOut),
          content: Text(UIConstants.signOutConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(UIConstants.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(UIConstants.signOut),
            ),
          ],
        );
      },
    );
  }
}
