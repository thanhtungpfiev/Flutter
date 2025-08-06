import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:ecommerce_clone_getx/app/data/auth/models/user_signup_req_model.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/repositories/auth_repository.dart';

class SignupUseCase implements UseCase<Either, UserSignupReqModel> {
  SignupUseCase({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either> call({UserSignupReqModel? params}) async {
    return await authRepository.signup(params!);
  }
}
