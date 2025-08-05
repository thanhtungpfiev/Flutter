import 'package:ecommerce_clone_getx/app/data/auth/data_sources/auth_service.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  // @override
  // Future<Either> signup(UserSignupReqModel user) async {
  //   return await authService.signup(user);
  // }

  // @override
  // Future<Either> signin(UserSigninReqModel user) async {
  //   return await authService.signin(user);
  // }

  // @override
  // Future<Either> getAges() async {
  //   return await authService.getAges();
  // }

  // @override
  // Future<Either> sendPasswordResetEmail(String email) async {
  //   return await authService.sendPasswordResetEmail(email);
  // }

  @override
  Future<bool> isLoggedIn() async {
    return await authService.isLoggedIn();
  }

  // @override
  // Future<Either> signOut() async {
  //   return await authService.signOut();
  // }

  // @override
  // Future<Either> getUser() async {
  //   var user = await authService.getUser();
  //   return user.fold(
  //     (error) {
  //       return Left(error);
  //     },
  //     (data) {
  //       return Right(UserModel.fromMap(data).toEntity());
  //     },
  //   );
  // }
}
