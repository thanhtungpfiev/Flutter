part of 'trending_movie_bloc.dart';

@immutable
abstract class TrendingMovieState {}

class TrendingMovieInitial extends TrendingMovieState {}

class TrendingMovieLoading extends TrendingMovieState {}

class TrendingMovieLoaded extends TrendingMovieState {
  final List<MovieEntity> movies;

  TrendingMovieLoaded(this.movies);
}

class TrendingMovieError extends TrendingMovieState {
  final String message;

  TrendingMovieError(this.message);
}
