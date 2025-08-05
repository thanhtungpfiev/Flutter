import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/repositories/auth_repository.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  IsLoggedInUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<bool> call({params}) async {
    return await authRepository.isLoggedIn();
  }
}
