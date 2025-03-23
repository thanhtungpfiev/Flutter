import 'package:dartz/dartz.dart';
import 'package:netflix/core/usecase/usecase.dart';
import 'package:netflix/data/auth/models/signin_req_model.dart';
import 'package:netflix/domain/auth/repositories/auth_repository.dart';
import 'package:netflix/service_locator.dart';

class SigninUseCase extends UseCase<Either, SigninReqModel> {
  @override
  Future<Either> call({SigninReqModel? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}
