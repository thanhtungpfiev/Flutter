import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel(
      {required super.id,
      required super.title,
      required super.overview,
      required super.posterPath});

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] as int,
      title: map['title'] as String,
      overview: map['overview'] as String,
      posterPath: map['poster_path'] as String,
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
        id: id, title: title, overview: overview, posterPath: posterPath);
  }
}
