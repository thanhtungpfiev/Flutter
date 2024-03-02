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

  const LocalUserModel.empty() : super.empty();

  factory LocalUserModel.fromMap(DataMap map) {
    return LocalUserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      points: (map['points'] as num).toInt(),
      fullName: map['fullName'] as String,
      profilePic: map['profilePic'] as String?,
      bio: map['bio'] as String?,
      groupIds: (map['groupIds'] as List<dynamic>).cast<String>(),
      enrolledCourseIds:
          (map['enrolledCourseIds'] as List<dynamic>).cast<String>(),
      following: (map['following'] as List<dynamic>).cast<String>(),
      followers: (map['followers'] as List<dynamic>).cast<String>(),
    );
  }

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
