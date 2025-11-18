import 'package:flutter/material.dart';

class AuthFieldWidget extends StatelessWidget {
  final String hintText;

  const AuthFieldWidget({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(decoration: InputDecoration(hintText: hintText));
  }
}
