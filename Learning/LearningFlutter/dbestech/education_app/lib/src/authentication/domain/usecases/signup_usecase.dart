import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class SignUpUseCase extends UseCaseWithParams<void, SignUpParams> {
  SignUpUseCase(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(SignUpParams params) {
    return _repository.signUp(
      fullName: params.fullName,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
  });

  const SignUpParams.empty()
      : fullName = '',
        email = '',
        password = '';

  final String fullName;
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
