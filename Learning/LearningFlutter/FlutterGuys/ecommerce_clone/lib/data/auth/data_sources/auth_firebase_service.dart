import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/constants/auth_constants.dart';
import 'package:ecommerce_clone/core/constants/firebase_error_constants.dart';
import 'package:ecommerce_clone/core/constants/message_constants.dart';
import 'package:ecommerce_clone/core/constants/prefs_constants.dart';
import 'package:ecommerce_clone/data/auth/data_sources/auth_service.dart';
import 'package:ecommerce_clone/data/auth/models/user_signin_req_model.dart';
import 'package:ecommerce_clone/data/auth/models/user_signup_req_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthFirebaseService implements AuthService {
  @override
  Future<Either> signup(UserSignupReqModel user) async {
    try {
      var returnedData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email!,
            password: user.password!,
          );

      await FirebaseFirestore.instance
          .collection(AuthConstants.users)
          .doc(returnedData.user!.uid)
          .set({
            AuthConstants.firstName: user.firstName,
            AuthConstants.lastName: user.lastName,
            AuthConstants.email: user.email,
            AuthConstants.gender: user.gender,
            AuthConstants.age: user.age,
            AuthConstants.image: returnedData.user!.photoURL,
            AuthConstants.userId: returnedData.user!.uid,
          });

      // Save authentication state to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefsConstants.isLoggedIn, true);
      await prefs.setString(PrefsConstants.userEmail, user.email!);

      return const Right(MessageConstants.signUpSuccess);
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == FirebaseErrorConstants.weakPassword) {
        message = MessageConstants.weakPassword;
      } else if (e.code == FirebaseErrorConstants.emailAlreadyInUse) {
        message = MessageConstants.emailAlreadyInUse;
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signin(UserSigninReqModel user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email!,
        password: user.password!,
      );

      // Save authentication state to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefsConstants.isLoggedIn, true);
      await prefs.setString(PrefsConstants.userEmail, user.email!);

      return const Right(MessageConstants.signInSuccess);
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == FirebaseErrorConstants.invalidEmail) {
        message = MessageConstants.userNotFound;
      } else if (e.code == FirebaseErrorConstants.invalidCredential) {
        message = MessageConstants.wrongPassword;
      } else {
        message = e.message ?? MessageConstants.unknownError;
      }

      return Left(message);
    }
  }

  @override
  Future<Either> getAges() async {
    try {
      var returnedData =
          await FirebaseFirestore.instance.collection(AuthConstants.ages).get();
      return Right(returnedData.docs);
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right(MessageConstants.passwordResetEmailSent);
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    // First check Firebase Auth - with persistence enabled, this should work on desktop
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // If Firebase Auth has a user, update local storage for additional reliability
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefsConstants.isLoggedIn, true);
      await prefs.setString(PrefsConstants.userEmail, currentUser.email ?? '');
      return true;
    }

    // Fallback: Check SharedPreferences if Firebase Auth doesn't have a user
    // This handles edge cases where Firebase persistence might not work
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PrefsConstants.isLoggedIn) ?? false;
  }

  @override
  Future<void> signOut() async {
    try {
      // Clear SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefsConstants.isLoggedIn, false);
      await prefs.remove(PrefsConstants.userEmail);

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // Handle any errors during sign out
      print('Error during sign out: $e');
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return const Left(MessageConstants.noUserSignedIn);
      }

      var userData = await FirebaseFirestore.instance
          .collection(AuthConstants.users)
          .doc(currentUser.uid)
          .get()
          .then((value) => value.data());

      if (userData == null) {
        return const Left(MessageConstants.userDataNotFound);
      }

      return Right(userData);
    } catch (e) {
      return const Left(MessageConstants.pleaseRetry);
    }
  }
}
