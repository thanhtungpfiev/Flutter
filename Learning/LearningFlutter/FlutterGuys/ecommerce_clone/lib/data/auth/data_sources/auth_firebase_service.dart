import 'dart:async';

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
      // Use Future.microtask to ensure proper thread handling
      var returnedData = await Future.microtask(() async {
        return await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email!,
          password: user.password!,
        );
      });

      await Future.microtask(() async {
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
      } else {
        message = e.message ?? MessageConstants.unknownError;
      }
      return Left(message);
    } catch (e) {
      // Handle any other unexpected errors
      return Left('${MessageConstants.unknownError}: ${e.toString()}');
    }
  }

  @override
  Future<Either> signin(UserSigninReqModel user) async {
    try {
      // Use Future.microtask to ensure proper thread handling
      await Future.microtask(() async {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email!,
          password: user.password!,
        );
      });

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
    } catch (e) {
      // Handle any other unexpected errors
      return Left('${MessageConstants.unknownError}: ${e.toString()}');
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
    } on FirebaseAuthException catch (e) {
      // Handle Firebase Auth specific errors
      return Left(e.message ?? MessageConstants.pleaseRetry);
    } catch (e) {
      // Handle any other unexpected errors
      return Left('${MessageConstants.pleaseRetry}: ${e.toString()}');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    // Use Future.microtask to ensure proper thread handling for Firebase Auth
    final currentUser = await Future.microtask(
      () => FirebaseAuth.instance.currentUser,
    );

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
  Future<Either> signOut() async {
    try {
      // Clear SharedPreferences first
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(PrefsConstants.isLoggedIn, false);
      await prefs.remove(PrefsConstants.userEmail);

      // Sign out from Firebase with proper thread handling
      await Future.microtask(() async {
        await FirebaseAuth.instance.signOut();
      });

      return const Right(MessageConstants.signOutSuccess);
    } catch (e) {
      // Handle any errors during sign out and return Left with error message
      return Left('${MessageConstants.signOutError}: ${e.toString()}');
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      // Ensure Firebase is initialized and add retry logic
      int retryCount = 0;
      const maxRetries = 3;

      while (retryCount < maxRetries) {
        try {
          // Use Future.microtask for thread safety with additional delay
          await Future.delayed(Duration(milliseconds: 100 * (retryCount + 1)));

          var currentUser = await Future.microtask(
            () => FirebaseAuth.instance.currentUser,
          );

          if (currentUser == null) {
            return const Left(MessageConstants.noUserSignedIn);
          }

          var userData = await Future.microtask(() async {
            return await FirebaseFirestore.instance
                .collection(AuthConstants.users)
                .doc(currentUser.uid)
                .get()
                .timeout(
                  const Duration(seconds: 10),
                  onTimeout: () => throw TimeoutException('Firestore timeout'),
                )
                .then((value) => value.data());
          });

          if (userData == null) {
            return const Left(MessageConstants.userDataNotFound);
          }

          return Right(userData);
        } catch (e) {
          retryCount++;
          if (retryCount >= maxRetries) {
            rethrow;
          }
          // Wait before retry
          await Future.delayed(Duration(milliseconds: 500 * retryCount));
        }
      }

      return const Left(MessageConstants.pleaseRetry);
    } catch (e) {
      return Left('${MessageConstants.pleaseRetry}: ${e.toString()}');
    }
  }
}
