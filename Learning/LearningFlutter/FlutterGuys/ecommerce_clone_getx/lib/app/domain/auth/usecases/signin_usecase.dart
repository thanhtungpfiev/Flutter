import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/data/auth/models/user_signin_req_model.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/repositories/auth_repository.dart';

class SigninUseCase implements UseCase<Either, UserSigninReqModel> {
  SigninUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either> call({UserSigninReqModel? params}) async {
    return authRepository.signin(params!);
  }
}
