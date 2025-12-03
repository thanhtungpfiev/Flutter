import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpUsecaseParams {
  final String name;
  final String email;
  final String password;

  SignUpUsecaseParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignUpUseCase
    implements UseCase<Either<Failure, UserEntity>, SignUpUsecaseParams> {
  final AuthRepository authRepository;
  SignUpUseCase({required this.authRepository});

  @override
  Future<Either<Failure, UserEntity>> call({
    SignUpUsecaseParams? params,
  }) async {
    return await authRepository.signUpWithNameEmailPassword(
      name: params!.name,
      email: params.email,
      password: params.password,
    );
  }
}
