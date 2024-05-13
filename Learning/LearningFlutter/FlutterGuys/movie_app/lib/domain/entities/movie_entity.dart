class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String posterPath;

//<editor-fold desc="Data Methods">
  const MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          overview == other.overview &&
          posterPath == other.posterPath);

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ overview.hashCode ^ posterPath.hashCode;

  @override
  String toString() {
    return 'MovieEntity{ id: $id, title: $title, overview: $overview, posterPath: $posterPath,}';
  }

  MovieEntity copyWith({
    int? id,
    String? title,
    String? overview,
    String? posterPath,
  }) {
    return MovieEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
    };
  }

  factory MovieEntity.fromMap(Map<String, dynamic> map) {
    return MovieEntity(
      id: map['id'] as int,
      title: map['title'] as String,
      overview: map['overview'] as String,
      posterPath: map['poster_path'] as String,
    );
  }

//</editor-fold>
}
