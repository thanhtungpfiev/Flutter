import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/core/services/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:blog_app/features/auth/data/extensions/user_model_extension.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final ConnectionChecker connectionChecker;

  AuthRepositoryImpl({
    required this.authDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, UserEntity>> signUpWithNameEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await authDataSource.signUpWithNameEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await authDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = authDataSource.currentUserSession;

        if (session == null) {
          return Left(Failure('User not logged in!'));
        }

        return Right(
          UserModel(
            userId: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ).toEntity(),
        );
      }
      final userModel = await authDataSource.getCurrentUserData();
      if (userModel != null) {
        return Right(userModel.toEntity());
      } else {
        return Left(Failure('No user is currently signed in.'));
      }
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
