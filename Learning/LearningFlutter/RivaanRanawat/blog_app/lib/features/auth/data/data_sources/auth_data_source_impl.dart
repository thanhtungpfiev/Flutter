import 'package:blog_app/core/error/server_exception.dart';
import 'package:blog_app/core/utils/app_logger.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase/supabase.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final SupabaseClient supabaseClient;
  AuthDataSourceImpl({required this.supabaseClient});

  @override
  Future<UserModel> signUpWithNameEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      // Try to obtain the user from the response. Depending on Supabase
      // configuration (e.g. email confirmation required) `response.user`
      // or `response.session` might be null. Prefer the explicit user
      // object when available, otherwise check for session->user.
      final user = response.user ?? response.session?.user;

      if (user == null) {
        throw ServerException(
          'Sign up completed — confirmation may be required.',
        );
      }

      return UserModel.fromJson(user.toJson());
    } catch (e) {
      // Map known Supabase auth errors to ServerException for repository
      // handling; fall back to the error's toString() for unknown cases.
      AppLogger.d('Error during sign up: $e');
      if (e is AuthException) {
        // Supabase AuthException.message is often the server message
        throw ServerException(e.message);
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }
}
