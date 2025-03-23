// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SigninReqModel {
  final String email;
  final String password;

  SigninReqModel({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  factory SigninReqModel.fromMap(Map<String, dynamic> map) {
    return SigninReqModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SigninReqModel.fromJson(String source) =>
      SigninReqModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
