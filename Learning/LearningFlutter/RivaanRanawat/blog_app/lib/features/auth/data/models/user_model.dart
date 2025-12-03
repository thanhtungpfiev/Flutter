// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String userId;
  final String email;
  final String name;

  UserModel({required this.userId, required this.email, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handles both direct User object from Supabase and custom map
    // Supabase user: id, email, user_metadata['name']
    final userId = json['userId'] ?? json['id'] ?? '';
    final email = json['email'] ?? '';
    // Try both direct and nested user_metadata for name
    String? name = json['name'];
    if (name == null &&
        json['user_metadata'] != null &&
        json['user_metadata'] is Map) {
      name = json['user_metadata']['name'] as String?;
    }
    return UserModel(userId: userId, email: email, name: name ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'email': email, 'name': name};
  }

  UserModel copyWith({String? userId, String? email, String? name}) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
