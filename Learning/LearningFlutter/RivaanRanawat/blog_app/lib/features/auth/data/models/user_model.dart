class UserModel {
  final String userId;
  final String email;
  final String name;

  UserModel({required this.userId, required this.email, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'email': email, 'name': name};
  }
}
