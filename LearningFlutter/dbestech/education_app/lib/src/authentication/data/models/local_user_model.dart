import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/local_user_entity.dart';

class LocalUserModel extends LocalUserEntity {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupIds,
    super.enrolledCourseIds,
    super.following,
    super.followers,
    super.profilePic,
    super.bio,
  });

  factory LocalUserModel.fromMap(DataMap map) {
    return LocalUserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      profilePic: map['profilePic'] as String,
      bio: map['bio'] as String,
      points: map['points'] as int,
      fullName: map['fullName'] as String,
      groupIds: map['groupIds'] as List<String>,
      enrolledCourseIds: map['enrolledCourseIds'] as List<String>,
      following: map['following'] as List<String>,
      followers: map['followers'] as List<String>,
    );
  }

  const LocalUserModel.empty() : super.empty();

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'profilePic': profilePic,
      'bio': bio,
      'points': points,
      'fullName': fullName,
      'groupIds': groupIds,
      'enrolledCourseIds': enrolledCourseIds,
      'following': following,
      'followers': followers,
    };
  }
}
