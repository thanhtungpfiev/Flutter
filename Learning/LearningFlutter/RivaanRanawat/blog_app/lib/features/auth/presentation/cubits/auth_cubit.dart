import 'package:blog_app/core/common/entities/user_entity.dart';
import 'package:blog_app/core/utils/app_logger.dart';
import 'package:blog_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthCubit({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await signUpUseCase(
      params: SignUpUseCaseParams(name: name, email: email, password: password),
    );

    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (userEntity) {
        emit(AuthSuccess(userEntity: userEntity));
      },
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await signInUseCase(
      params: SignInUseCaseParams(email: email, password: password),
    );

    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (userEntity) {
        emit(AuthSuccess(userEntity: userEntity));
      },
    );
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    final result = await getCurrentUserUseCase();

    AppLogger.i("GetCurrentUserUseCase result: $result");

    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (userEntity) {
        emit(AuthSuccess(userEntity: userEntity));
      },
    );
  }
}
