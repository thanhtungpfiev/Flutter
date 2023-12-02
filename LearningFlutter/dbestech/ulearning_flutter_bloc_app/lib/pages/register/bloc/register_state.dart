part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;

  const RegisterState(
      {this.userName = '',
      this.email = '',
      this.password = '',
      this.confirmPassword = ''});

  @override
  List<Object> get props => [userName, email, password, confirmPassword];

  RegisterState copyWith({
    String? userName,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
