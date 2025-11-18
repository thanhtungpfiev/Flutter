import 'package:blog_app/core/utils/responsive_utils.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field_widget.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign Up.',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: ResponsiveUtils.height(30)),
          AuthFieldWidget(hintText: 'Name'),
          AuthFieldWidget(hintText: 'Email'),
          AuthFieldWidget(hintText: 'Password'),
        ],
      ),
    );
  }
}
