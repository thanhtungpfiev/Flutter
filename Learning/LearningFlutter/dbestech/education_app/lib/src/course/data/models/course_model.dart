import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course_entity.dart';

class CourseModel extends CourseEntity {
  const CourseModel({
    required super.id,
    required super.title,
    required super.numberOfExams,
    required super.numberOfMaterials,
    required super.numberOfVideos,
    required super.groupId,
    required super.createdAt,
    required super.updatedAt,
    super.description,
    super.image,
    super.imageIsFile = false,
  });

  CourseModel.empty() : super.empty();

  factory CourseModel.fromMap(DataMap map) {
    return CourseModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      numberOfExams: map['numberOfExams'] as int,
      numberOfMaterials: map['numberOfMaterials'] as int,
      numberOfVideos: map['numberOfVideos'] as int,
      groupId: map['groupId'] as String,
      image: map['image'] as String?,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'numberOfExams': numberOfExams,
      'numberOfMaterials': numberOfMaterials,
      'numberOfVideos': numberOfVideos,
      'groupId': groupId,
      'image': image,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  @override
  CourseModel copyWith({
    String? id,
    String? title,
    int? numberOfExams,
    int? numberOfMaterials,
    int? numberOfVideos,
    String? groupId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    String? image,
    bool? imageIsFile,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      image: image ?? this.image,
      imageIsFile: imageIsFile ?? this.imageIsFile,
    );
  }
}
