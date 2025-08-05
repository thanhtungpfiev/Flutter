// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:ecommerce_clone/common/enums/gender.dart';
// import 'package:ecommerce_clone/core/constants/auth_constants.dart';

// class UserModel {
//   final String userId;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String image;
//   final Gender gender;

//   UserModel({
//     required this.userId,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.image,
//     required this.gender,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       AuthConstants.userId: userId,
//       AuthConstants.firstName: firstName,
//       AuthConstants.lastName: lastName,
//       AuthConstants.email: email,
//       AuthConstants.image: image,
//       AuthConstants.gender: gender.toFirestore(),
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       userId: map[AuthConstants.userId] as String,
//       firstName: map[AuthConstants.firstName] as String,
//       lastName: map[AuthConstants.lastName] as String,
//       email: map[AuthConstants.email] as String,
//       image: map[AuthConstants.image] ?? '',
//       gender: Gender.fromFirestore(map[AuthConstants.gender] as String),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModel.fromJson(String source) =>
//       UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
