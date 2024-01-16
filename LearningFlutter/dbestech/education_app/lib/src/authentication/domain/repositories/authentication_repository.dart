import 'package:education_app/core/common/enums/update_user_enums.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/local_user_entity.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();
  ResultFuture<LocalUserEntity> signIn({
    required String email,
    required String password,
  });
  ResultFuture<void> signUp({
    required String fullName,
    required String email,
    required String password,
  });
  ResultFuture<void> forgotPassword({required String email});
  ResultFuture<void> updateUser({
    required UpdateUserActionEnums action,
    dynamic userData,
  });
}
