import 'package:ecommerce_clone_getx/app/common/enums/gender.dart';

class UserEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final Gender gender;

  UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
    required this.gender,
  });
}
