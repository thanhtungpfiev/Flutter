import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_cubit.dart';
import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_state.dart';
import 'package:ecommerce_clone/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce_clone/common/widgets/app_bar/basic_app_bar.dart';
import 'package:ecommerce_clone/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
import 'package:ecommerce_clone/data/auth/models/user_signin_req_model.dart';
import 'package:ecommerce_clone/domain/auth/usecases/signin_usecase.dart';
import 'package:ecommerce_clone/presentation/auth/pages/forgot_password_page.dart';
import 'package:ecommerce_clone/presentation/home/pages/home_page.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnterPasswordPage extends StatefulWidget {
  const EnterPasswordPage({super.key, required this.signinReqModel});

  final UserSigninReqModel signinReqModel;

  @override
  State<EnterPasswordPage> createState() => _EnterPasswordPageState();
}

class _EnterPasswordPageState extends State<EnterPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

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
            child: BlocProvider(
              create: (context) => sl<BasicReactiveButtonCubit>(),
              child: BlocListener<
                BasicReactiveButtonCubit,
                BasicReactiveButtonState
              >(
                listener: (context, state) {
                  if (state is BasicReactiveButtonLoadErrorState) {
                    var snackbar = SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }
                  if (state is BasicReactiveButtonLoadSuccessState) {
                    AppNavigator.pushAndRemoveUntil(context, const HomePage());
                  }
                },
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
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Form is valid, proceed with signin
              widget.signinReqModel.password = _passwordController.text;
              context.read<BasicReactiveButtonCubit>().execute(
                usecase: sl<SigninUseCase>(),
                params: widget.signinReqModel,
              );
            }
          },
          title: UIConstants.continueText,
        );
      },
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
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    AppNavigator.push(context, ForgotPasswordPage());
                  },
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
