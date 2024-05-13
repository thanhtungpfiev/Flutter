import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  const CourseEntity({
    required this.id,
    required this.title,
    required this.numberOfExams,
    required this.numberOfMaterials,
    required this.numberOfVideos,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.image,
    this.imageIsFile = false,
  });

  CourseEntity.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          description: '_empty.description',
          numberOfExams: 0,
          numberOfMaterials: 0,
          numberOfVideos: 0,
          groupId: '_empty.groupId',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

  final String id;
  final String title;
  final String? description;
  final int numberOfExams;
  final int numberOfMaterials;
  final int numberOfVideos;
  final String groupId;
  final String? image;
  final bool imageIsFile;
  final DateTime createdAt;
  final DateTime updatedAt;

  CourseEntity copyWith({
    String? id,
    String? title,
    String? description,
    int? numberOfExams,
    int? numberOfMaterials,
    int? numberOfVideos,
    String? groupId,
    String? image,
    bool? imageIsFile,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CourseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      groupId: groupId ?? this.groupId,
      image: image ?? this.image,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id];
}
