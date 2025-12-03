import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/core/common/entities/user_entity.dart';

extension UserModelExtension on UserModel {
  UserEntity toEntity() {
    return UserEntity(userId: userId, email: email, name: name);
  }
}
