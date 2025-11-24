import 'package:blog_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignUpUseCase signUpUseCase;
  AuthCubit({required this.signUpUseCase}) : super(AuthInitial());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await signUpUseCase(
      params: SignUpUsecaseParams(name: name, email: email, password: password),
    );

    result.fold(
      (failure) {
        emit(AuthFailure(errorMessage: failure.message));
      },
      (userEntity) {
        emit(AuthSuccess(userId: userEntity.userId));
      },
    );
  }
}
