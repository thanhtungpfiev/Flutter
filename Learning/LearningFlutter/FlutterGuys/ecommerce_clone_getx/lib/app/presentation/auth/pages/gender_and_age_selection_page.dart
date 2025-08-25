import 'package:ecommerce_clone_getx/app/common/controllers/button/basic_reactive_button_controller.dart';
import 'package:ecommerce_clone_getx/app/common/enums/gender.dart';
import 'package:ecommerce_clone_getx/app/common/helper/bottom_sheet/app_bottom_sheet.dart';
import 'package:ecommerce_clone_getx/app/common/helper/theme/theme_helper.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone_getx/app/core/configs/theme/app_colors.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/data/auth/models/user_signup_req_model.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/signup_usecase.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/controllers/age_selection_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/controllers/ages_display_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/controllers/gender_selection_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/widgets/ages_widget.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderAndAgeSelectionPage extends StatelessWidget {
  const GenderAndAgeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userSignupReqModel =
        (Get.arguments as Map<String, dynamic>)[UIConstants.userSignupReqModel]
            as UserSignupReqModel;

    return Scaffold(
      appBar: const BasicAppBar(),
      body: Column(
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
          _finishButton(context, userSignupReqModel),
        ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        genderTile(context, Gender.men),
        SizedBox(width: ResponsiveUtils.width(20)),
        genderTile(context, Gender.women),
      ],
    );
  }

  Expanded genderTile(BuildContext context, Gender gender) {
    final genderController = Get.find<GenderSelectionController>();
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          genderController.selectGender(gender);
        },
        child: Obx(() {
          return Container(
            height: ResponsiveUtils.height(60),
            decoration: BoxDecoration(
              color: genderController.selectedGender.value == gender
                  ? AppColors.primary
                  : ThemeHelper.getSecondBackground(context),
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
          );
        }),
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
    final agesDisplayController = Get.find<AgesDisplayController>();
    final ageSelectionController = Get.find<AgeSelectionController>();
    return Obx(() {
      return GestureDetector(
        onTap: () {
          agesDisplayController.displayAges();
          AppBottomSheet.display(Get.context!, const AgesWidget());
        },
        child: Container(
          height: ResponsiveUtils.height(60),
          padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
          decoration: BoxDecoration(
            color: ThemeHelper.getSecondBackground(Get.context!),
            borderRadius: BorderRadius.circular(ResponsiveUtils.radius(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ageSelectionController.selectedAge.value),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      );
    });
  }

  Widget _finishButton(
    BuildContext context,
    UserSignupReqModel userSignupReqModel,
  ) {
    final genderController = Get.find<GenderSelectionController>();
    final ageController = Get.find<AgeSelectionController>();
    final buttonController = BasicReactiveButtonController();
    return Container(
      height: ResponsiveUtils.height(60),
      color: ThemeHelper.getSecondBackground(context),
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.width(16)),
      child: Center(
        child: BasicReactiveButton(
          controller: buttonController,
          onPressed: () async {
            userSignupReqModel.gender = genderController.selectedGender.value
                .toFirestore();
            userSignupReqModel.age = ageController.selectedAge.value;
            await buttonController.execute(
              usecase: sl<SignupUseCase>(),
              params: userSignupReqModel,
            );
            if (buttonController.state.value ==
                BasicReactiveButtonState.error) {
              var snackbar = SnackBar(
                content: Text(buttonController.errorMessage.value),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            } else {
              Get.offNamedUntil(Routes.home, (route) => false);
            }
          },
          title: UIConstants.finish,
        ),
      ),
    );
  }
}
