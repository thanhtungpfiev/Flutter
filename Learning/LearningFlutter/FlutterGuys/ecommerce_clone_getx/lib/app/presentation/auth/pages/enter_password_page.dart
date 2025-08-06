import 'package:ecommerce_clone_getx/app/common/controllers/button/basic_reactive_button_controller.dart';
import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/data/auth/models/user_signin_req_model.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/signin_usecase.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterPasswordPage extends StatefulWidget {
  const EnterPasswordPage({super.key});

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  late final UserSigninReqModel signinReqModel;

  @override
  void initState() {
    super.initState();
    signinReqModel =
        (Get.arguments as Map<String, dynamic>)[UIConstants.userSigninReqModel]
            as UserSigninReqModel;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

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
                  _signinText(context),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _passwordField(context),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _continueButton(context),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _forgotPassword(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signinText(BuildContext context) {
    return Text(
      UIConstants.signIn,
      style: TextStyle(
        fontSize: ResponsiveUtils.fontSize(32),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        hintText: UIConstants.enterPassword,
        hintStyle: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        contentPadding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.height(16),
          horizontal: ResponsiveUtils.width(16),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return UIConstants.pleaseEnterPassword;
        }
        if (value.length < 6) {
          return UIConstants.passwordMinLength;
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
          signinReqModel.password = _passwordController.text;
          await controller.execute(
            usecase: sl<SigninUseCase>(),
            params: signinReqModel,
          );
          if (controller.errorMessage != null) {
            var snackbar = SnackBar(
              content: Text(controller.errorMessage!),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          } else {
            Get.offNamedUntil(Routes.home, (route) => false);
          }
        }
      },
      title: UIConstants.continueText,
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: ResponsiveUtils.fontSize(14),
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        children: [
          TextSpan(text: UIConstants.forgotPasswordText),
          TextSpan(
            text: UIConstants.resetText,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(Routes.forgotPassword);
              },
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
