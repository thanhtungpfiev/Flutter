import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(hideBack: true),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.width(16),
            vertical: ResponsiveUtils.width(40),
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
                  _emailField(context),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _continueButton(context),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _createAccount(context),
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

  Widget _emailField(BuildContext context) {
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return UIConstants.pleaseEnterEmail;
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return UIConstants.pleaseEnterValidEmail;
        }
        return null;
      },
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Form is valid, proceed with navigation
          // AppNavigator.push(
          //   context,
          //   EnterPasswordPage(
          //     signinReqModel: UserSigninReqModel(email: _emailController.text),
          //   ),
          // );
        }
      },
      title: UIConstants.continueText,
      height: ResponsiveUtils.height(50),
      content: ResponsiveUtils.isDesktop
          ? Text(
              UIConstants.continueText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: ResponsiveUtils.fontSize(16),
              ),
            )
          : null,
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: ResponsiveUtils.fontSize(14),
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        children: [
          TextSpan(text: UIConstants.dontHaveAccount),
          TextSpan(
            text: UIConstants.createOne,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // AppNavigator.push(context, SignupPage());
              },
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
