import 'package:blog_app/core/helpers/navigator/app_navigator.dart';
import 'package:blog_app/core/services/app_user/app_user_service.dart';
import 'package:blog_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A simple gate that checks current user and redirects to the
/// appropriate auth page. If getting current user succeeds we
/// show the `SignupPage`, otherwise `SigninPage`.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (!mounted) return;
        if (state is AuthSuccess) {
          sl<AppUserService>().saveUser(state.userEntity);
          AppNavigator.pushReplacement(context, const BlogPage());
        } else if (state is AuthFailure) {
          sl<AppUserService>().clear();
          AppNavigator.pushReplacement(context, const SigninPage());
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
