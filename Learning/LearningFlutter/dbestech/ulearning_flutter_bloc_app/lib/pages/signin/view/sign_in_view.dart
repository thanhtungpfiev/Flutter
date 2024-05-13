import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/routes/routes.dart';
import '../bloc/sign_in_bloc.dart';
import '../controller/sign_in_controller.dart';
import '../../../common/widgets/common_widget.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar('Log In'),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildThirdPartyLogin(context),
                    Center(
                      child: reusableText('Or use your email account to login'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 66.h),
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText('Email'),
                          SizedBox(
                            height: 5.h,
                          ),
                          buildTextField(
                            'Enter your email address',
                            'email',
                            'user',
                            (value) => context.read<SignInBloc>().add(
                                  EmailEvent(value),
                                ),
                          ),
                          reusableText('Password'),
                          SizedBox(
                            height: 5.h,
                          ),
                          buildTextField(
                            'Enter your email password',
                            'password',
                            'lock',
                            (value) => context.read<SignInBloc>().add(
                                  PasswordEvent(value),
                                ),
                          ),
                        ],
                      ),
                    ),
                    forgotPassword(),
                    buildLogInAndRegButton('Login', 'login', () {
                      SignInController(context: context).handleSignIn('email');
                    }),
                    buildLogInAndRegButton('Register', 'register', () {
                      Navigator.of(context).pushNamed(AppRoutes.register);
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
