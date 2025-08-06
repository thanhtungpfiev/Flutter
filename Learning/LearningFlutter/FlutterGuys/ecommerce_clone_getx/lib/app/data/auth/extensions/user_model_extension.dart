import 'package:ecommerce_clone_getx/app/data/auth/models/user_model.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/entities/user_entity.dart';

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
