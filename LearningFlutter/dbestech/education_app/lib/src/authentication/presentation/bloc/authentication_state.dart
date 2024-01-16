part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {
  const AuthenticationInitialState();
}

class AuthenticationLoadingState extends AuthenticationState {
  const AuthenticationLoadingState();
}

class AuthenticationErrorState extends AuthenticationState {
  const AuthenticationErrorState({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class AuthenticationSignedInState extends AuthenticationState {
  const AuthenticationSignedInState({required this.localUserEntity});

  final LocalUserEntity localUserEntity;

  @override
  List<Object> get props => [localUserEntity];
}

class AuthenticationSignedUpState extends AuthenticationState {
  const AuthenticationSignedUpState();
}

class AuthenticationForgotPasswordSentState extends AuthenticationState {
  const AuthenticationForgotPasswordSentState();
}

class AuthenticationUserUpdatedState extends AuthenticationState {
  const AuthenticationUserUpdatedState();
}
