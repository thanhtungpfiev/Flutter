import 'package:blog_app/core/constants/ui_constants.dart';
import 'package:blog_app/core/helpers/navigator/app_navigator.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:blog_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
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
      return 'Password is required.';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.width(16)),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return AbsorbPointer(
              absorbing: isLoading,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      UIConstants.signUp,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.height(30)),
                    _nameField(),
                    SizedBox(height: ResponsiveUtils.height(15)),
                    _emailField(),
                    SizedBox(height: ResponsiveUtils.height(15)),
                    _passwordField(),
                    SizedBox(height: ResponsiveUtils.height(20)),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Sign up successful'),
                              backgroundColor: AppColors.successColor,
                            ),
                          );
                          // Optionally navigate away or pop
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                              backgroundColor: AppColors.errorColor,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return SizedBox(
                            height: 48,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return _signUpButton(context);
                      },
                    ),
                    SizedBox(height: ResponsiveUtils.height(20)),
                    _alreadyHaveAccountText(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  GestureDetector _alreadyHaveAccountText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, SigninPage());
      },
      child: RichText(
        text: TextSpan(
          text: 'Already have an account? ',
          style: Theme.of(context).textTheme.titleMedium,
          children: [
            TextSpan(
              text: 'Sign In',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.gradient2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AuthGradientButton _signUpButton(BuildContext context) {
    return AuthGradientButton(
      buttonText: UIConstants.signUp,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<AuthCubit>().signUp(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please fix the errors above'),
              backgroundColor: AppColors.errorColor,
            ),
          );
        }
      },
    );
  }

  AuthFieldWidget _passwordField() {
    return AuthFieldWidget(
      hintText: 'Password',
      controller: passwordController,
      validator: _validatePassword,
      isObscureText: true,
    );
  }

  AuthFieldWidget _emailField() {
    return AuthFieldWidget(
      hintText: 'Email',
      controller: emailController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Email address is required';
        }
        if (!_isValidEmail(value.trim())) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  AuthFieldWidget _nameField() {
    return AuthFieldWidget(
      hintText: 'Name',
      controller: nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        if (value.length < 2) {
          return 'Name must be at least 2 characters long';
        }
        return null;
      },
    );
  }
}
