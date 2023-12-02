import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/routes/routes.dart';
import '../../../common/values/constants.dart';
import '../../../common/widgets/flutter_toast.dart';
import '../../../global.dart';
import '../bloc/sign_in_bloc.dart';

class SignInController {
  final BuildContext context;

  SignInController({required this.context});

  Future<void> handleSignIn(String type) async {
    try {
      if (type == 'email') {
        final state = context.read<SignInBloc>().state;
        String email = state.email;
        String password = state.password;
        if (email.isEmpty) {
          toastInfo(msg: 'Email is empty');
          return;
        }
        if (password.isEmpty) {
          toastInfo(msg: 'Password is empty');
          return;
        }
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
          var user = credential.user;
          if (user == null) {
            toastInfo(msg: 'User does not exist');
            return;
          } else {
            if (!user.emailVerified) {
              toastInfo(msg: 'User does not be verified');
              return;
            }
            Global.storageService
                .setString(AppConstants.storageUserTokenKey, '12345678');
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.application, (route) => false);
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-email') {
            toastInfo(msg: 'Email address is not valid');
          } else if (e.code == 'user-disabled') {
            toastInfo(
                msg: 'User corresponding to the given email has been disabled');
          } else if (e.code == 'user-not-found') {
            toastInfo(msg: 'No user corresponding to the given email');
          } else if (e.code == 'wrong password') {
            toastInfo(
                msg:
                    'Password is invalid for the given email, or the account corresponding to the email does not have a password set');
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
