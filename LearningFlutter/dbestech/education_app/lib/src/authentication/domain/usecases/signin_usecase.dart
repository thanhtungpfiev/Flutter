import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/local_user_entity.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class SignInUseCase extends UseCase<LocalUserEntity, SignInParams> {
  const SignInUseCase(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture<LocalUserEntity> call({SignInParams? params}) {
    return _repository.signIn(email: params!.email, password: params.password);
  }
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});
  const SignInParams.empty()
      : email = '',
        password = '';

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
