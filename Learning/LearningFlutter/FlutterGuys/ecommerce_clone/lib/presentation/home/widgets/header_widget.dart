import 'package:ecommerce_clone/common/enums/gender.dart';
import 'package:ecommerce_clone/core/configs/assets/app_images.dart';
import 'package:ecommerce_clone/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/domain/auth/entities/user_entity.dart';
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
        padding: const EdgeInsets.only(top: 40, right: 16, left: 16),
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
      onTap: () {
        // AppNavigator.push(context, const SettingsPage());
      },
      child: Container(
        height: 40,
        width: 40,
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

  Widget _gender(UserEntity user) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          user.gender == Gender.men ? 'Men' : 'Women',
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
    );
  }

  Widget _card(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // AppNavigator.push(context, const CartPage());
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(AppVectors.bag, fit: BoxFit.none),
      ),
    );
  }
}
