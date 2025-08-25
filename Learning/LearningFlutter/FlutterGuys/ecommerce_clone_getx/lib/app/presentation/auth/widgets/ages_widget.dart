import 'package:ecommerce_clone_getx/app/core/constants/auth_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/controllers/age_selection_controller.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/controllers/ages_display_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgesWidget extends StatelessWidget {
  const AgesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final agesDisplayController = Get.find<AgesDisplayController>();
    return SizedBox(
      height: ResponsiveUtils.screenHeight / 2.7,
      child: Obx(() {
        if (agesDisplayController.state.value == AgesDisplayState.loading) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
        if (agesDisplayController.state.value == AgesDisplayState.error) {
          return Container(
            alignment: Alignment.center,
            child: Text(agesDisplayController.errorMessage.value),
          );
        }
        return _ages(context, agesDisplayController.ages);
      }),
    );
  }

  Widget _ages(BuildContext context, List ages) {
    final ageSelectionController = Get.find<AgeSelectionController>();
    return ListView.separated(
      padding: EdgeInsets.all(ResponsiveUtils.width(16)),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            ageSelectionController.selectAge(
              ages[index].data()[AuthConstants.value],
            );
          },
          child: Text(
            ages[index].data()[AuthConstants.value],
            style: TextStyle(fontSize: ResponsiveUtils.fontSize(18)),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: ResponsiveUtils.height(20)),
      itemCount: ages.length,
    );
  }
}
