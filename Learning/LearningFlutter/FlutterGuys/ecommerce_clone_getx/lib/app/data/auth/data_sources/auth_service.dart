import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/data/auth/models/user_signin_req_model.dart';
import 'package:ecommerce_clone_getx/app/data/auth/models/user_signup_req_model.dart';

abstract class AuthService {
  Future<Either> signup(UserSignupReqModel user);
  Future<Either> signin(UserSigninReqModel user);
  Future<Either> getAges();
  Future<Either> sendPasswordResetEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either> signOut();
  Future<Either> getUser();
}
