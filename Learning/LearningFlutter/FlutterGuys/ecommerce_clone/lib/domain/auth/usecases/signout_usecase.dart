import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:ecommerce_clone/domain/auth/repositories/auth_repository.dart';

class SignOutUseCase implements UseCase<Either, dynamic> {
  SignOutUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either> call({dynamic params}) async {
    return await authRepository.signOut();
  }
}
