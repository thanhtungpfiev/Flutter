import 'package:dartz/dartz.dart';
import 'package:spotify_clone/data/datasources/auth/auth_service.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';
import 'package:spotify_clone/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl(this.authService);

  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await authService.signup(createUserReq);
  }

  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await authService.signin(signinUserReq);
  }

  @override
  Future<Either> getUser() async {
    return await authService.getUser();
  }
}
