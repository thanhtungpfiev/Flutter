import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/repositories/auth_repository.dart';

class SendPasswordResetEmailUseCase implements UseCase<Either, String> {
  SendPasswordResetEmailUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either> call({String? params}) async {
    return authRepository.sendPasswordResetEmail(params!);
  }
}
