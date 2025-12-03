import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase/supabase.dart';

abstract interface class AuthDataSource {
  Future<UserModel> signUpWithNameEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Session? get currentUserSession;

  Future<UserModel?> getCurrentUserData();
}
