import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce_clone_getx/app/core/configs/assets/app_vectors.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PasswordResetEmailPage extends StatelessWidget {
  const PasswordResetEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _emailSending(),
          SizedBox(height: ResponsiveUtils.height(30)),
          _sentEmail(),
          SizedBox(height: ResponsiveUtils.width(30)),
          _returnToLoginButton(context),
        ],
      ),
    );
  }

  Widget _emailSending() {
    return Center(child: SvgPicture.asset(AppVectors.emailSending));
  }

  Widget _sentEmail() {
    return Center(
      child: Text(
        UIConstants.passwordResetEmailSent,
        style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
      ),
    );
  }

  Widget _returnToLoginButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        Get.offNamed(Routes.signin);
      },
      width: ResponsiveUtils.width(200),
      title: UIConstants.returnToLogin,
    );
  }
}
