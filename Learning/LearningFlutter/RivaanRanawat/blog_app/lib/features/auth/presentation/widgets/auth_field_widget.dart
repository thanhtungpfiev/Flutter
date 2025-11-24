import 'package:flutter/material.dart';

class AuthFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isObscureText;

  const AuthFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: isObscureText,
    );
  }
}
