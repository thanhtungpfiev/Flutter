import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netflix/core/constants/api_url.dart';
import 'package:netflix/core/network/dio_client.dart';
import 'package:netflix/data/auth/models/signin_req_model.dart';
import 'package:netflix/data/auth/models/signup_req_model.dart';
import 'package:netflix/service_locator.dart';

abstract class AuthService {
  Future<Either> signup(SignupReqModel params);
  Future<Either> signin(SigninReqModel params);
}

class AuthServiceApiImpl extends AuthService {
  @override
  Future<Either> signup(SignupReqModel params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.signup,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signin(SigninReqModel params) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrl.signin,
        data: params.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
