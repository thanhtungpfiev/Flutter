import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignInUsecaseParams {
  final String email;
  final String password;

  SignInUsecaseParams({required this.email, required this.password});
}

class SignInUseCase
    implements UseCase<Either<Failure, UserEntity>, SignInUsecaseParams> {
  final AuthRepository authRepository;
  SignInUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call({
    SignInUsecaseParams? params,
  }) async {
    return await authRepository.signInWithEmailPassword(
      email: params!.email,
      password: params.password,
    );
  }
}
