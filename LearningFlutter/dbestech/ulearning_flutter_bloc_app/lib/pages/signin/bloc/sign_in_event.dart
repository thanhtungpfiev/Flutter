part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class EmailEvent extends SignInEvent {
  final String email;

  const EmailEvent(this.email);

  @override
  List<Object?> get props => [email];
}

class PasswordEvent extends SignInEvent {
  final String password;

  const PasswordEvent(this.password);

  @override
  List<Object?> get props => [password];
}
