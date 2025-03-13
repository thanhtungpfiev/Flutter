import 'package:dartz/dartz.dart';
import 'package:netflix/core/usecase/usecase.dart';
import 'package:netflix/data/auth/models/signup_req_model.dart';
import 'package:netflix/domain/auth/repositories/auth_repository.dart';
import 'package:netflix/service_locator.dart';

class SignupUseCase extends UseCase<Either, SignupReqModel> {
  @override
  Future<Either> call({SignupReqModel? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }
}
