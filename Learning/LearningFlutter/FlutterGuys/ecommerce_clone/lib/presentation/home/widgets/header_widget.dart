import 'package:ecommerce_clone/common/enums/gender.dart';
import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/core/configs/assets/app_images.dart';
import 'package:ecommerce_clone/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/auth/entities/user_entity.dart';
import 'package:ecommerce_clone/domain/auth/usecases/signout_usecase.dart';
import 'package:ecommerce_clone/presentation/auth/pages/signin_page.dart';
import 'package:ecommerce_clone/presentation/cart/pages/cart_page.dart';
import 'package:ecommerce_clone/presentation/home/blocs/user_info_display_cubit.dart';
import 'package:ecommerce_clone/presentation/home/blocs/user_info_display_state.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserInfoDisplayCubit>()..displayUserInfo(),
      child: Padding(
        padding: EdgeInsets.only(
          top: ResponsiveUtils.width(40),
          right: ResponsiveUtils.width(16),
          left: ResponsiveUtils.width(16),
        ),
        child: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
          builder: (context, state) {
            if (state is UserInfoDisplayLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserInfoDisplayLoadSuccessState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _profileImage(state.user, context),
                  _gender(state.user),
                  _card(context),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _profileImage(UserEntity user, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Show confirmation dialog before signing out
        final shouldSignOut = await _showSignOutDialog(context);
        if (shouldSignOut == true) {
          await _signOut(context);
        }
      },
      child: Container(
        height: ResponsiveUtils.height(40.0),
        width: ResponsiveUtils.width(40.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                user.image.isEmpty
                    ? const AssetImage(AppImages.profile)
                    : NetworkImage(user.image),
          ),
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Future<bool?> _showSignOutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Perform sign out
      await sl<SignOutUseCase>().call();

      // Remove loading indicator
      if (!context.mounted) return;
      Navigator.of(context).pop();

      // Navigate to sign in page and remove all previous routes
      AppNavigator.pushAndRemoveUntil(context, SigninPage());
    } catch (e) {
      // Remove loading indicator if there's an error
      if (!context.mounted) return;
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing out: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _gender(UserEntity user) {
    return Container(
      height: ResponsiveUtils.height(40.0),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(100)),
      ),
      child: Center(
        child: Text(
          user.gender == Gender.men
              ? Gender.menDisplayName
              : Gender.womenDisplayName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveUtils.fontSize(16),
          ),
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, const CartPage());
      },
      child: Container(
        height: ResponsiveUtils.height(40.0),
        width: ResponsiveUtils.width(40.0),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(AppVectors.bag, fit: BoxFit.none),
      ),
    );
  }
}
