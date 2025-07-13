import 'package:ecommerce_clone/domain/auth/entities/user_entity.dart';

abstract class UserInfoDisplayState {}

class UserInfoDisplayLoadingState extends UserInfoDisplayState {}

class UserInfoDisplayLoadSuccessState extends UserInfoDisplayState {
  final UserEntity user;
  UserInfoDisplayLoadSuccessState({required this.user});
}

class UserInfoDisplayLoadErrorState extends UserInfoDisplayState {}
