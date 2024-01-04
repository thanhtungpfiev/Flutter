// ignore_for_file: lines_longer_than_80_chars

import 'package:education_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

class PageContentEntity extends Equatable {
  const PageContentEntity({
    required this.image,
    required this.title,
    required this.description,
  });

  const PageContentEntity.first()
      : this(
          image: MediaRes.casualReading,
          title: 'Brand new curriculum',
          description: 'This is the first online education platform designed by the '
              "world's top professors",
        );

  const PageContentEntity.second()
      : this(
          image: MediaRes.casualLife,
          title: 'Brand a fun atmosphere',
          description: 'This is the first online education platform designed by the '
              "world's top professors",
        );

  const PageContentEntity.third()
      : this(
          image: MediaRes.casualMeditationScience,
          title: 'Easy to join the lesson',
          description: 'This is the first online education platform designed by the '
              "world's top professors",
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
