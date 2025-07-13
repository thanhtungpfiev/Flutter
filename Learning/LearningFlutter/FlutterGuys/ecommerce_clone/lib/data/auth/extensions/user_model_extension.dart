import 'package:ecommerce_clone/data/auth/models/user_model.dart';
import 'package:ecommerce_clone/domain/auth/entities/user_entity.dart';

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      image: image,
      gender: gender,
    );
  }
}
