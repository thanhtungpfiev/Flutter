import 'package:blog_app/features/auth/data/models/user_model.dart';

abstract interface class AuthDataSource {
  Future<UserModel> signUpWithNameEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  });
}
