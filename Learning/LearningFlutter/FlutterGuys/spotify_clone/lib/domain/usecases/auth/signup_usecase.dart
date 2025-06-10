import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/configs/usecase/usecase.dart';
import 'package:spotify_clone/data/models/auth/create_user_req.dart';
import 'package:spotify_clone/domain/repositories/auth/auth_repository.dart';

class SignupUseCase implements UseCase<Either, CreateUserReq> {
  final AuthRepository authRepository;

  SignupUseCase(this.authRepository);

  @override
  Future<Either> call({CreateUserReq? params}) async {
    return authRepository.signUp(params!);
  }
}
