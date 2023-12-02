import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/common_widget.dart';
import '../bloc/register_bloc.dart';
import '../controller/register_controller.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: buildAppBar('Sign Up'),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: reusableText(
                          'Enter your details below & free sign up'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText('User name'),
                          buildTextField(
                            'Enter your user name',
                            'user',
                            'user',
                            (value) => context
                                .read<RegisterBloc>()
                                .add(UserNameEvent(value)),
                          ),
                          reusableText('Email'),
                          buildTextField(
                            'Enter your email address',
                            'email',
                            'user',
                            (value) => context
                                .read<RegisterBloc>()
                                .add(EmailEvent(value)),
                          ),
                          reusableText('Password'),
                          buildTextField(
                            'Enter your password',
                            'password',
                            'lock',
                            (value) => context
                                .read<RegisterBloc>()
                                .add(PasswordEvent(value)),
                          ),
                          reusableText('Confirm Password'),
                          buildTextField(
                            'Enter your confirm password',
                            'password',
                            'lock',
                            (value) => context
                                .read<RegisterBloc>()
                                .add(ConfirmPasswordEvent(value)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25.w),
                      child: reusableText(
                          'By creating an account you have to agree with our indication.'),
                    ),
                    buildLogInAndRegButton('Sign Up', 'login', () {
                      RegisterController(context: context)
                          .handleEmailRegister();
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
