import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:education_app/core/common/enums/update_user_enums.dart';
import 'package:education_app/src/authentication/domain/entities/local_user_entity.dart';
import 'package:education_app/src/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:education_app/src/authentication/domain/usecases/signin_usecase.dart';
import 'package:education_app/src/authentication/domain/usecases/signup_usecase.dart';
import 'package:education_app/src/authentication/domain/usecases/update_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._forgotPasswordUseCase,
    this._updateUserUseCase,
  ) : super(const AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {
      emit(const AuthenticationLoadingState());
    });
    on<AuthenticationSignInEvent>(_signInHandler);
    on<AuthenticationSignUpEvent>(_signUpHandler);
    on<AuthenticationForgotPasswordEvent>(_forgotPasswordHandler);
    on<AuthenticationUpdateUserEvent>(_updateUserHandler);
  }

  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  Future<FutureOr<void>> _signInHandler(
    AuthenticationSignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _signInUseCase.call(
      params: SignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AuthenticationErrorState(message: failure.message)),
      (user) => emit(
        AuthenticationSignedInState(localUserEntity: user),
      ),
    );
  }

  FutureOr<void> _signUpHandler(
    AuthenticationSignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _signUpUseCase.call(
      params: SignUpParams(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AuthenticationErrorState(message: failure.message)),
      (_) => emit(const AuthenticationSignedUpState()),
    );
  }

  FutureOr<void> _forgotPasswordHandler(
    AuthenticationForgotPasswordEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _forgotPasswordUseCase.call(params: event.email);
    result.fold(
      (failure) => emit(AuthenticationErrorState(message: failure.message)),
      (_) => emit(const AuthenticationForgotPasswordSentState()),
    );
  }

  FutureOr<void> _updateUserHandler(
    AuthenticationUpdateUserEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _updateUserUseCase.call(
      params: UpdateUserParams(
        action: event.action,
        userData: event.userData,
      ),
    );
    result.fold(
      (failure) => emit(AuthenticationErrorState(message: failure.message)),
      (_) => emit(const AuthenticationUserUpdatedState()),
    );
  }
}
