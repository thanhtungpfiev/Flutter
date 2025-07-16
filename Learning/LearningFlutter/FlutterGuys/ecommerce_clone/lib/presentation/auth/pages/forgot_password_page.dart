import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_cubit.dart';
import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_state.dart';
import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/domain/auth/usecases/send_password_reset_email_usecase.dart';
import 'package:ecommerce_clone/presentation/auth/pages/password_reset_email_page.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Center(
        child: BlocProvider(
          create: (context) => BasicReactiveButtonCubit(),
          child:
              BlocListener<BasicReactiveButtonCubit, BasicReactiveButtonState>(
                listener: (context, state) {
                  if (state is BasicReactiveButtonLoadErrorState) {
                    var snackbar = SnackBar(
                      content: Text(state.errorMessage),
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }

                  if (state is BasicReactiveButtonLoadSuccessState) {
                    AppNavigator.push(context, const PasswordResetEmailPage());
                  }
                },
                child: SingleChildScrollView(
                  padding: ResponsiveUtils.pagePadding,
                  child: SizedBox(
                    width: ResponsiveUtils.maxFormWidth,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _signinText(),
                          SizedBox(height: ResponsiveUtils.spacing32),
                          _emailField(),
                          SizedBox(height: ResponsiveUtils.spacing32),
                          _continueButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }

  Widget _signinText() {
    return Text(
      'Forgot Password',
      style: TextStyle(
        fontSize: ResponsiveUtils.font32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      style: TextStyle(fontSize: ResponsiveUtils.font16),
      decoration: InputDecoration(
        hintText: 'Enter Email',
        hintStyle: TextStyle(fontSize: ResponsiveUtils.font16),
        contentPadding: ResponsiveUtils.formPadding,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _continueButton() {
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Form is valid, proceed with the logic
              context.read<BasicReactiveButtonCubit>().execute(
                usecase: sl<SendPasswordResetEmailUseCase>(),
                params: _emailController.text,
              );
            }
          },
          title: 'Continue',
        );
      },
    );
  }
}
