import 'package:blog_app/core/constants/ui_constants.dart';
import 'package:blog_app/core/helpers/navigator/app_navigator.dart';
import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:blog_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
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
      return UIConstants.signInPasswordRequired;
    }
    if (password.length < 8) {
      return UIConstants.signInPasswordMinLength8;
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
                      UIConstants.signIn,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.height(30)),
                    _emailField(),
                    SizedBox(height: ResponsiveUtils.height(15)),
                    _passwordField(),
                    SizedBox(height: ResponsiveUtils.height(20)),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Sign in successful'),
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
                        return _signInButton(context);
                      },
                    ),
                    SizedBox(height: ResponsiveUtils.height(20)),
                    _dontHaveAccountText(context),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  GestureDetector _dontHaveAccountText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, SignupPage());
      },
      child: RichText(
        text: TextSpan(
          text: UIConstants.signInDontHaveAccount,
          style: Theme.of(context).textTheme.titleMedium,
          children: [
            TextSpan(
              text: UIConstants.signInSignUpButtonText,
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

  AuthGradientButton _signInButton(BuildContext context) {
    return AuthGradientButton(
      buttonText: UIConstants.signIn,
      onPressed: () {
        if (formKey.currentState!.validate()) {
          context.read<AuthCubit>().signIn(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(UIConstants.signInPleaseFixErrors),
              backgroundColor: AppColors.errorColor,
            ),
          );
        }
      },
    );
  }

  AuthFieldWidget _passwordField() {
    return AuthFieldWidget(
      hintText: UIConstants.signInPasswordHintText,
      controller: passwordController,
      validator: _validatePassword,
      isObscureText: true,
    );
  }

  AuthFieldWidget _emailField() {
    return AuthFieldWidget(
      hintText: UIConstants.signInEmailHintText,
      controller: emailController,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return UIConstants.signInEmailRequired;
        }
        if (!_isValidEmail(value.trim())) {
          return UIConstants.signInPleaseEnterValidEmail;
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }
}
