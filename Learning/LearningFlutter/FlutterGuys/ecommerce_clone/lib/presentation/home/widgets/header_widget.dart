import 'package:ecommerce_clone/common/enums/gender.dart';
import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone/core/configs/assets/app_images.dart';
import 'package:ecommerce_clone/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/auth/entities/user_entity.dart';
import 'package:ecommerce_clone/presentation/cart/pages/cart_page.dart';
import 'package:ecommerce_clone/presentation/home/blocs/user_info_display_cubit.dart';
import 'package:ecommerce_clone/presentation/home/blocs/user_info_display_state.dart';
import 'package:ecommerce_clone/presentation/settings/pages/settings_page.dart';
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _defaultProfileImage(context),
                  _defaultGender(context),
                  _card(context),
                ],
              );
            }
            if (state is UserInfoDisplayLoadSuccessState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _profileImage(state.user, context),
                  _gender(state.user, context),
                  _card(context),
                ],
              );
            }
            // Error state or unknown state - show default header
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _defaultProfileImage(context),
                _defaultGender(context),
                _card(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _profileImage(UserEntity user, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        AppNavigator.push(context, const SettingsPage());
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

  Widget _gender(UserEntity user, BuildContext context) {
    return Container(
      height: ResponsiveUtils.height(40.0),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      decoration: BoxDecoration(
        color: ThemeHelper.getSecondBackground(context),
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

  Widget _defaultProfileImage(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        AppNavigator.push(context, const SettingsPage());
      },
      child: Container(
        height: ResponsiveUtils.height(40.0),
        width: ResponsiveUtils.width(40.0),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.profile)),
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _defaultGender(BuildContext context) {
    return Container(
      height: ResponsiveUtils.height(40.0),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      decoration: BoxDecoration(
        color: ThemeHelper.getSecondBackground(context),
        borderRadius: BorderRadius.circular(ResponsiveUtils.radius(100)),
      ),
      child: Center(
        child: Text(
          Gender.menDisplayName, // Default to men
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveUtils.fontSize(16),
          ),
        ),
      ),
    );
  }
}
