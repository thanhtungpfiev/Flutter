part of 'popular_movie_bloc.dart';

@immutable
abstract class PopularMovieState {}

class PopularMovieInitial extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final List<MovieEntity> movies;

  PopularMovieLoaded(this.movies);
}

class PopularMovieError extends PopularMovieState {
  final String message;

  PopularMovieError(this.message);
}
