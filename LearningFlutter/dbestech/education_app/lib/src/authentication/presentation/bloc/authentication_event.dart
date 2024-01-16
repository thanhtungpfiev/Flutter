part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationSignInEvent extends AuthenticationEvent {
  const AuthenticationSignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class AuthenticationSignUpEvent extends AuthenticationEvent {
  const AuthenticationSignUpEvent({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  @override
  List<Object> get props => [fullName, email, password];
}

class AuthenticationForgotPasswordEvent extends AuthenticationEvent {
  const AuthenticationForgotPasswordEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class AuthenticationUpdateUserEvent extends AuthenticationEvent {
  AuthenticationUpdateUserEvent({
    required this.action,
    required this.userData,
  }) : assert(
            userData is String || userData is File,
            '[userData] must be '
            'either a String or a File, but was ${userData.runtimeType}');

  final UpdateUserActionEnums action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
