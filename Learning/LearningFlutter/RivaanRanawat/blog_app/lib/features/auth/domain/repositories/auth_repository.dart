import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithNameEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> getCurrentUser();
}
