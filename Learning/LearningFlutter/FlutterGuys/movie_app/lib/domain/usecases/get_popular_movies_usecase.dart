import '../../core/errors/server_failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetPopularMoviesUseCase {
  MovieRepository movieRepository;

  GetPopularMoviesUseCase(this.movieRepository);

  Future<Either<Failure, List<MovieEntity>>> call() {
    return movieRepository.getPopularMovies();
  }
}
