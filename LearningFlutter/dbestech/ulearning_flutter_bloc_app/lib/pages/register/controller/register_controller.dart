import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/flutter_toast.dart';
import '../bloc/register_bloc.dart';

class RegisterController {
  final BuildContext context;

  const RegisterController({required this.context});

  Future<void> handleEmailRegister() async {
    final state = context.read<RegisterBloc>().state;

    final String userName = state.userName;
    final String email = state.email;
    final String password = state.password;
    final String confirmPassword = state.confirmPassword;

    if (userName.isEmpty) {
      toastInfo(msg: 'Username cannot be empty');
      return;
    }
    if (email.isEmpty) {
      toastInfo(msg: 'Email cannot be empty');
      return;
    }
    if (password.isEmpty) {
      toastInfo(msg: 'Password cannot be empty');
      return;
    }
    if (confirmPassword.isEmpty) {
      toastInfo(msg: 'Confirm password cannot be empty');
      return;
    }
    if (confirmPassword != password) {
      toastInfo(msg: 'Confirm password not match with password');
      return;
    }

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        await credential.user!.sendEmailVerification();
        await credential.user!.updateDisplayName(userName);
        String photoURL = 'uploads/default.png';
        await credential.user!.updatePhotoURL(photoURL);

        toastInfo(
            msg:
                'An email has been sent to your registered email. To activate it please check your email box and click the link.');
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        toastInfo(
            msg: 'Already exists an account with the given email address');
      } else if (e.code == 'invalid-email') {
        toastInfo(msg: 'The email address is not valid');
      } else if (e.code == 'operation-not-allowed') {
        toastInfo(msg: 'Email/password accounts are not enabled');
      } else if (e.code == 'weak-password') {
        toastInfo(msg: 'The password is not strong enough');
      } else {
        toastInfo(msg: e.toString());
      }
    }
  }
}
