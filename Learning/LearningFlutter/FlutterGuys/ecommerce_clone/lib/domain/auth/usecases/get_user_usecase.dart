import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:ecommerce_clone/domain/auth/repositories/auth_repository.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  GetUserUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either> call({dynamic params}) async {
    return await authRepository.getUser();
  }
}
