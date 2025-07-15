import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/common/widgets/button/basic_app_button.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/data/auth/models/user_signup_req_model.dart';
import 'package:ecommerce_clone/presentation/auth/pages/gender_and_age_selection_page.dart';
import 'package:ecommerce_clone/presentation/auth/pages/signin_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
      return 'Password is required';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: ResponsiveUtils.pagePadding,
          child: Container(
            width: ResponsiveUtils.maxFormWidth,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _signupText(),
                  SizedBox(height: ResponsiveUtils.spacing24),
                  _firstNameField(),
                  SizedBox(height: ResponsiveUtils.spacing20),
                  _lastNameField(),
                  SizedBox(height: ResponsiveUtils.spacing20),
                  _emailField(),
                  SizedBox(height: ResponsiveUtils.spacing20),
                  _passwordField(context),
                  SizedBox(height: ResponsiveUtils.spacing32),
                  _continueButton(context),
                  SizedBox(height: ResponsiveUtils.spacing24),
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
      'Create Account',
      style: TextStyle(
        fontSize: ResponsiveUtils.font32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _firstNameField() {
    return TextFormField(
      controller: _firstNameController,
      style: TextStyle(fontSize: ResponsiveUtils.font16),
      decoration: InputDecoration(
        hintText: 'First Name',
        hintStyle: TextStyle(fontSize: ResponsiveUtils.font16),
        contentPadding: ResponsiveUtils.formPadding,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'First name is required';
        }
        if (value.trim().length < 2) {
          return 'First name must be at least 2 characters long';
        }
        return null;
      },
    );
  }

  Widget _lastNameField() {
    return TextFormField(
      controller: _lastNameController,
      style: TextStyle(fontSize: ResponsiveUtils.font16),
      decoration: InputDecoration(
        hintText: 'Last Name',
        hintStyle: TextStyle(fontSize: ResponsiveUtils.font16),
        contentPadding: ResponsiveUtils.formPadding,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Last name is required';
        }
        if (value.trim().length < 2) {
          return 'Last name must be at least 2 characters long';
        }
        return null;
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      style: TextStyle(fontSize: ResponsiveUtils.font16),
      decoration: InputDecoration(
        hintText: 'Email Address',
        hintStyle: TextStyle(fontSize: ResponsiveUtils.font16),
        contentPadding: ResponsiveUtils.formPadding,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Email address is required';
        }
        if (!_isValidEmail(value.trim())) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      style: TextStyle(fontSize: ResponsiveUtils.font16),
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(fontSize: ResponsiveUtils.font16),
        contentPadding: ResponsiveUtils.formPadding,
      ),
      obscureText: false,
      validator: _validatePassword,
    );
  }

  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // All validations passed, proceed to next page
          AppNavigator.push(
            context,
            GenderAndAgeSelectionPage(
              userSignupReqModel: UserSignupReqModel(
                firstName: _firstNameController.text.trim(),
                email: _emailController.text.trim(),
                lastName: _lastNameController.text.trim(),
                password: _passwordController.text,
              ),
            ),
          );
        } else {
          // Show a snackbar or some feedback that validation failed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fix the errors above'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      title: 'Continue',
      height: ResponsiveUtils.buttonHeight,
      content:
          ResponsiveUtils.isDesktop
              ? Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: ResponsiveUtils.font16,
                ),
              )
              : null,
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: ResponsiveUtils.font14,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
        children: [
          const TextSpan(text: "Do you have an account? "),
          TextSpan(
            text: 'Signin',
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.pushReplacement(context, SigninPage());
                  },
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
