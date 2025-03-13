import 'package:dartz/dartz.dart';
import 'package:netflix/data/auth/models/signin_req_model.dart';
import 'package:netflix/data/auth/models/signup_req_model.dart';

abstract class AuthRepository {
  Future<Either> signup(SignupReqModel params);
  Future<Either> signin(SigninReqModel params);
  Future<bool> isLoggedIn();
}
