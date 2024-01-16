import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';

class ForgotPasswordUseCase extends UseCase<void, String> {
  const ForgotPasswordUseCase(this._repository);
  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call({String? params}) {
    return _repository.forgotPassword(email: params!);
  }
}
