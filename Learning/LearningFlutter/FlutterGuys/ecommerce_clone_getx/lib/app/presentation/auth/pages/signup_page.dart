import 'package:ecommerce_clone_getx/app/common/routes/app_pages.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone_getx/app/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone_getx/app/data/auth/models/user_signup_req_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Email validation helper
  bool _isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  // Password validation helper
  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return UIConstants.passwordRequired;
    }
    if (password.length < 8) {
      return UIConstants.passwordMinLength8;
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      return UIConstants.passwordComplexity;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
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
                  _signupText(),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _firstNameField(),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _lastNameField(),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _emailField(),
                  SizedBox(height: ResponsiveUtils.height(20)),
                  _passwordField(context),
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

  Widget _signupText() {
    return Text(
      UIConstants.createAccount,
      style: TextStyle(
        fontSize: ResponsiveUtils.fontSize(32),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _firstNameField() {
    return TextFormField(
      controller: _firstNameController,
      style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
      decoration: InputDecoration(
        hintText: UIConstants.firstName,
        hintStyle: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        contentPadding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.height(16),
          horizontal: ResponsiveUtils.width(16),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return UIConstants.firstNameRequired;
        }
        if (value.trim().length < 2) {
          return UIConstants.firstNameMinLength;
        }
        return null;
      },
    );
  }

  Widget _lastNameField() {
    return TextFormField(
      controller: _lastNameController,
      style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
      decoration: InputDecoration(
        hintText: UIConstants.lastName,
        hintStyle: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        contentPadding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.height(16),
          horizontal: ResponsiveUtils.width(16),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return UIConstants.lastNameRequired;
        }
        if (value.trim().length < 2) {
          return UIConstants.lastNameMinLength;
        }
        return null;
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
      decoration: InputDecoration(
        hintText: UIConstants.emailAddress,
        hintStyle: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        contentPadding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.height(16),
          horizontal: ResponsiveUtils.width(16),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return UIConstants.emailRequired;
        }
        if (!_isValidEmail(value.trim())) {
          return UIConstants.pleaseEnterValidEmail;
        }
        return null;
      },
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
      decoration: InputDecoration(
        hintText: UIConstants.password,
        hintStyle: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
        contentPadding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.height(16),
          horizontal: ResponsiveUtils.width(16),
        ),
      ),
      obscureText: false,
      validator: _validatePassword,
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // All validations passed, proceed to next page using Get.to and arguments
          Get.toNamed(
            Routes.genderAndAgeSelection,
            arguments: {
              UIConstants.userSignupReqModel: UserSignupReqModel(
                firstName: _firstNameController.text.trim(),
                email: _emailController.text.trim(),
                lastName: _lastNameController.text.trim(),
                password: _passwordController.text,
              ),
            },
          );
        } else {
          // Show a snackbar or some feedback that validation failed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(UIConstants.pleaseFixErrors),
              backgroundColor: Colors.red,
            ),
          );
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
          TextSpan(text: UIConstants.doYouHaveAccount),
          TextSpan(
            text: UIConstants.signin,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.offNamed(Routes.signin);
              },
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
