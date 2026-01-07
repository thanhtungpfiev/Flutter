import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

extension BlogModelExtension on BlogModel {
  BlogEntity toEntity() {
    return BlogEntity(
      id: id,
      posterId: posterId,
      title: title,
      content: content,
      imageUrl: imageUrl,
      topics: topics,
      updatedAt: updatedAt,
      posterName: posterName,
    );
  }
}
