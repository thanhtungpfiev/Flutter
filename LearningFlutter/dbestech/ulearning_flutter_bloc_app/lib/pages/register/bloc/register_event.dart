part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class UserNameEvent extends RegisterEvent {
  final String userName;

  const UserNameEvent(this.userName);

  @override
  List<Object> get props => [userName];
}

class EmailEvent extends RegisterEvent {
  final String email;

  const EmailEvent(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordEvent extends RegisterEvent {
  final String password;

  const PasswordEvent(this.password);

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordEvent extends RegisterEvent {
  final String confirmPassword;

  const ConfirmPasswordEvent(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}
