import '../../core/errors/server_failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class SearchMoviesUseCase {
  MovieRepository movieRepository;

  SearchMoviesUseCase(this.movieRepository);

  Future<Either<Failure, List<MovieEntity>>> call(String query) {
    return movieRepository.searchMovies(query);
  }
}
