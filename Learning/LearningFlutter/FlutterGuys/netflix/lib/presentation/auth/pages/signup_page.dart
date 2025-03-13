import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:netflix/common/helper/message/display_message.dart';
import 'package:netflix/common/helper/navigation/app_navigator.dart';
import 'package:netflix/core/configs/theme/app_colors.dart';
import 'package:netflix/data/auth/models/signup_req_model.dart';
import 'package:netflix/domain/auth/usecases/signup_usecase.dart';
import 'package:netflix/presentation/auth/pages/signin_page.dart';
import 'package:netflix/presentation/home/pages/home_page.dart';
import 'package:netflix/service_locator.dart';
import 'package:reactive_button/reactive_button.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signupText(),
            const SizedBox(height: 30),
            _emailField(),
            const SizedBox(height: 20),
            _passwordField(),
            const SizedBox(height: 60),
            _signupButton(context),
            const SizedBox(height: 20),
            _signinText(context),
          ],
        ),
      ),
    );
  }

  Widget _signupText() {
    return const Text(
      'Sign Up',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }

  Widget _signupButton(BuildContext context) {
    return ReactiveButton(
      title: 'Sign Up',
      activeColor: AppColors.primary,
      onPressed:
          () async => await sl<SignupUseCase>().call(
            params: SignupReqModel(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ),
      onSuccess: () {
        AppNavigator.pushAndRemoveUntil(context, const HomePage());
      },
      onFailure: (String error) {
        DisplayMessage.errorMessage(error, context);
      },
    );
  }

  Widget _signinText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "Do you have account? "),
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(color: Colors.blue),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.push(context, SigninPage());
                  },
          ),
        ],
      ),
    );
  }
}
