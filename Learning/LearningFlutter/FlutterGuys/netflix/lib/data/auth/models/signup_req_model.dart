// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignupReqModel {
  final String email;
  final String password;

  SignupReqModel({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'password': password};
  }

  factory SignupReqModel.fromMap(Map<String, dynamic> map) {
    return SignupReqModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupReqModel.fromJson(String source) =>
      SignupReqModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
