import 'package:ecommerce_clone_getx/app/common/controllers/button/basic_reactive_button_controller.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/send_password_reset_email_usecase.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/routes/app_pages.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.width(40),
            vertical: ResponsiveUtils.height(16),
          ),
          child: SizedBox(
            width: ResponsiveUtils.maxFormWidth,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _signinText(),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _emailField(),
                  SizedBox(height: ResponsiveUtils.width(20)),
                  _continueButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signinText() {
    return Text(
      UIConstants.forgotPassword,
      style: TextStyle(
        fontSize: ResponsiveUtils.fontSize(32),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
      decoration: InputDecoration(
        hintText: UIConstants.enterEmail,
        hintStyle: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        contentPadding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.height(16),
          horizontal: ResponsiveUtils.width(16),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return UIConstants.pleaseEnterEmail;
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return UIConstants.pleaseEnterValidEmail;
        }
        return null;
      },
    );
  }

  Widget _continueButton(BuildContext context) {
    final controller = BasicReactiveButtonController();
    return BasicReactiveButton(
      controller: controller,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await controller.execute(
            usecase: sl<SendPasswordResetEmailUseCase>(),
            params: _emailController.text,
          );
          if (controller.state.value == BasicReactiveButtonState.error) {
            var snackbar = SnackBar(
              content: Text(controller.errorMessage!),
              behavior: SnackBarBehavior.floating,
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          } else {
            Get.toNamed(Routes.passwordResetEmail);
          }
        }
      },
      title: UIConstants.continueText,
    );
  }
}
