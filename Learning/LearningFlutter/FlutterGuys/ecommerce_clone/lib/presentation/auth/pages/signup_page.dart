import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/common/widgets/button/basic_app_button.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _signupText(),
              const SizedBox(height: 20),
              _firstNameField(),
              const SizedBox(height: 20),
              _lastNameField(),
              const SizedBox(height: 20),
              _emailField(),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 20),
              _continueButton(context),
              const SizedBox(height: 20),
              _createAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupText() {
    return const Text(
      'Create Account',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    );
  }

  Widget _firstNameField() {
    return TextFormField(
      controller: _firstNameController,
      decoration: const InputDecoration(hintText: 'First Name'),
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
      decoration: const InputDecoration(hintText: 'Last Name'),
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
      decoration: const InputDecoration(hintText: 'Email Address'),
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
      decoration: const InputDecoration(hintText: 'Password'),
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
    );
  }

  Widget _createAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
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
