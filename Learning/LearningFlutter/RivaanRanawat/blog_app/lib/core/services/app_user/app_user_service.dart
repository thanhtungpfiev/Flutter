import 'package:blog_app/core/common/entities/user_entity.dart';

class AppUserService {
  UserEntity? _currentUser;

  UserEntity? get currentUser => _currentUser;

  void saveUser(UserEntity? user) {
    _currentUser = user;
  }

  void clear() {
    _currentUser = null;
  }
}
