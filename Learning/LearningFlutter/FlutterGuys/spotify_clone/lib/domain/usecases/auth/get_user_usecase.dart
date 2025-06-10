import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/configs/usecase/usecase.dart';
import 'package:spotify_clone/domain/repositories/auth/auth_repository.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  final AuthRepository authRepository;

  GetUserUseCase(this.authRepository);

  @override
  Future<Either> call({params}) async {
    return await authRepository.getUser();
  }
}
