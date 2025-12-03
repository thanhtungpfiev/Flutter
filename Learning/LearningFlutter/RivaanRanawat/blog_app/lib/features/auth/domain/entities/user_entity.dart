// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserEntity {
  final String userId;
  final String email;
  final String name;

  UserEntity({required this.userId, required this.email, required this.name});

  @override
  String toString() =>
      'UserEntity(userId: $userId, email: $email, name: $name)';
}
