class UserSignupReqModel {
  UserSignupReqModel({
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.password,
  });

  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? gender;
  String? age;
}
