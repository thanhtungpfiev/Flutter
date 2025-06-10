import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/configs/usecase/usecase.dart';
import 'package:spotify_clone/data/models/auth/signin_user_req.dart';
import 'package:spotify_clone/domain/repositories/auth/auth_repository.dart';

class SigninUseCase implements UseCase<Either, SigninUserReq> {
  final AuthRepository authRepository;

  SigninUseCase(this.authRepository);

  @override
  Future<Either> call({SigninUserReq? params}) async {
    return authRepository.signin(params!);
  }
}
