import 'package:education_app/core/common/enums/update_user_enums.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUseCase extends UseCase<void, UpdateUserParams> {
  const UpdateUserUseCase(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call({UpdateUserParams? params}) {
    return _repository.updateUser(
        action: params!.action, userData: params.userData,);
  }
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  const UpdateUserParams.empty()
      : this(action: UpdateUserActionEnums.displayName, userData: '');

  final UpdateUserActionEnums action;

  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
