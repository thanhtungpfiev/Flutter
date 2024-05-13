import 'package:education_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

class PageContentEntity extends Equatable {
  const PageContentEntity({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  const PageContentEntity.first()
      : this(
          imagePath: MediaRes.casualReading,
          title: 'Brand new curriculum',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  const PageContentEntity.second()
      : this(
          imagePath: MediaRes.casualLife,
          title: 'Brand a fun atmosphere',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  const PageContentEntity.third()
      : this(
          imagePath: MediaRes.casualMeditationScience,
          title: 'Easy to join the lesson',
          description:
              'This is the first online education platform designed by the '
              "world's top professors",
        );

  final String imagePath;
  final String title;
  final String description;

  @override
  List<Object?> get props => [imagePath, title, description];
}
