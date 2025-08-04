import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_cubit.dart';
import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_state.dart';
import 'package:ecommerce_clone/common/enums/gender.dart';
import 'package:ecommerce_clone/common/helper/bottom_sheet/app_bottom_sheet.dart';
import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/utils/theme_utils.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/data/auth/models/user_signup_req_model.dart';
import 'package:ecommerce_clone/domain/auth/usecases/signup_usecase.dart';
import 'package:ecommerce_clone/presentation/auth/blocs/age_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/auth/blocs/ages_display_cubit.dart';
import 'package:ecommerce_clone/presentation/auth/blocs/gender_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/auth/widgets/ages_widget.dart';
import 'package:ecommerce_clone/presentation/home/pages/home_page.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderAndAgeSelectionPage extends StatelessWidget {
  const GenderAndAgeSelectionPage({
    super.key,
    required this.userSignupReqModel,
  });

  final UserSignupReqModel userSignupReqModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<GenderSelectionCubit>()),
          BlocProvider(create: (context) => sl<BasicReactiveButtonCubit>()),
          BlocProvider(create: (context) => sl<AgeSelectionCubit>()),
          BlocProvider(create: (context) => sl<AgesDisplayCubit>()),
        ],
        child: BlocListener<BasicReactiveButtonCubit, BasicReactiveButtonState>(
          listener: (context, state) {
            if (state is BasicReactiveButtonLoadErrorState) {
              var snackbar = SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
            if (state is BasicReactiveButtonLoadSuccessState) {
              AppNavigator.pushAndRemoveUntil(context, const HomePage());
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.width(16),
                  vertical: ResponsiveUtils.width(40),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tellUs(),
                    SizedBox(height: ResponsiveUtils.height(30)),
                    _genders(context),
                    SizedBox(height: ResponsiveUtils.height(30)),
                    _howOld(),
                    SizedBox(height: ResponsiveUtils.height(30)),
                    _age(),
                  ],
                ),
              ),
              const Spacer(),
              _finishButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tellUs() {
    return Text(
      UIConstants.tellUsAboutYourself,
      style: TextStyle(
        fontSize: ResponsiveUtils.fontSize(24),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _genders(BuildContext context) {
    return BlocBuilder<GenderSelectionCubit, Gender>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            genderTile(context, Gender.men),
            SizedBox(width: ResponsiveUtils.width(20)),
            genderTile(context, Gender.women),
          ],
        );
      },
    );
  }

  Expanded genderTile(BuildContext context, Gender gender) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.read<GenderSelectionCubit>().selectGender(gender);
        },
        child: Container(
          height: ResponsiveUtils.height(60),
          decoration: BoxDecoration(
            color:
                context.read<GenderSelectionCubit>().selectedGender == gender
                    ? AppColors.primary
                    : ThemeUtils.getSecondBackground(context),
            borderRadius: BorderRadius.circular(ResponsiveUtils.radius(30)),
          ),
          child: Center(
            child: Text(
              gender.displayName,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: ResponsiveUtils.fontSize(16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _howOld() {
    return Text(
      UIConstants.howOldAreYou,
      style: TextStyle(
        fontSize: ResponsiveUtils.fontSize(18),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _age() {
    return BlocBuilder<AgeSelectionCubit, String>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            AppBottomSheet.display(
              context,
              MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: context.read<AgeSelectionCubit>()),
                  BlocProvider.value(
                    value: context.read<AgesDisplayCubit>()..displayAges(),
                  ),
                ],
                child: const AgesWidget(),
              ),
            );
          },
          child: Container(
            height: ResponsiveUtils.height(60),
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.width(16),
            ),
            decoration: BoxDecoration(
              color: ThemeUtils.getSecondBackground(context),
              borderRadius: BorderRadius.circular(ResponsiveUtils.radius(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(state), const Icon(Icons.keyboard_arrow_down)],
            ),
          ),
        );
      },
    );
  }

  Widget _finishButton(BuildContext context) {
    return Container(
      height: ResponsiveUtils.height(60),
      color: ThemeUtils.getSecondBackground(context),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      child: Center(
        child: Builder(
          builder: (context) {
            return BasicReactiveButton(
              onPressed: () {
                userSignupReqModel.gender =
                    context
                        .read<GenderSelectionCubit>()
                        .selectedGender
                        .toFirestore();
                userSignupReqModel.age =
                    context.read<AgeSelectionCubit>().selectedAge;
                context.read<BasicReactiveButtonCubit>().execute(
                  usecase: sl<SignupUseCase>(),
                  params: userSignupReqModel,
                );
              },
              title: UIConstants.finish,
            );
          },
        ),
      ),
    );
  }
}
