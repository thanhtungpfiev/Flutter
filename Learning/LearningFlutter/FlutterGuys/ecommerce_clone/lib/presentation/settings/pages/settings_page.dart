import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_cubit.dart';
import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_state.dart';
import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/auth/usecases/signout_usecase.dart';
import 'package:ecommerce_clone/presentation/auth/pages/signin_page.dart';
import 'package:ecommerce_clone/presentation/settings/widgets/my_favorites_tile_widget.dart';
import 'package:ecommerce_clone/presentation/settings/widgets/my_orders_tile_widget.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  MyFavoritesTileWidget(),
                  SizedBox(height: ResponsiveUtils.height(15)),
                  MyOrdersTileWidget(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.width(16)),
            child: BlocProvider(
              create: (context) => sl<BasicReactiveButtonCubit>(),
              child: Builder(
                builder:
                    (context) => BlocListener<
                      BasicReactiveButtonCubit,
                      BasicReactiveButtonState
                    >(
                      listener: (context, state) {
                        if (state is BasicReactiveButtonLoadSuccessState) {
                          // Navigate to sign in page and remove all previous routes
                          AppNavigator.pushAndRemoveUntil(
                            context,
                            SigninPage(),
                          );
                        } else if (state is BasicReactiveButtonLoadErrorState) {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${UIConstants.errorSigningOut}${state.errorMessage}',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: BasicReactiveButton(
                        onPressed: () async {
                          final shouldSignOut = await showSignOutDialog(
                            context,
                          );
                          if (shouldSignOut == true && context.mounted) {
                            await context
                                .read<BasicReactiveButtonCubit>()
                                .execute(usecase: sl<SignOutUseCase>());
                          }
                        },
                        title: UIConstants.signOut,
                      ),
                    ),
              ),
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
