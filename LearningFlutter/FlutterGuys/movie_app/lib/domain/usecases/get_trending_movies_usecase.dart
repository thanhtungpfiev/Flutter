import '../../core/errors/server_failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetTrendingMoviesUseCase {
  MovieRepository movieRepository;

  GetTrendingMoviesUseCase(this.movieRepository);

  Future<Either<Failure, List<MovieEntity>>> call() {
    return movieRepository.getTrendingMovies();
  }
}
