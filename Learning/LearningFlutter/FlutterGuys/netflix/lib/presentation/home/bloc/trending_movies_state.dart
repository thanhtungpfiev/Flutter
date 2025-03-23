import 'package:netflix/domain/movie/entities/movie_entity.dart';

abstract class TrendingMoviesState {}

class TrendingMoviesLoadingState extends TrendingMoviesState {}

class TrendingMoviesLoadedState extends TrendingMoviesState {
  final List<MovieEntity> movies;

  TrendingMoviesLoadedState({required this.movies});
}

class TrendingMoviesLoadErrorState extends TrendingMoviesState {
  final String errorMessage;

  TrendingMoviesLoadErrorState({required this.errorMessage});
}
