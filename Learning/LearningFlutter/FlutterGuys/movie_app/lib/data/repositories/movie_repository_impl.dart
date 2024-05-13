import 'package:dartz/dartz.dart';

import '../../core/errors/server_exception.dart';
import '../../core/errors/server_failure.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/remote/movie_remote_data_source.dart';
import '../models/movie_model.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource movieRemoteDataSource;

  MovieRepositoryImpl({required this.movieRemoteDataSource});

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies() async {
    try {
      final List<MovieModel> listMovieModel =
          await movieRemoteDataSource.getPopularMovies();
      final List<MovieEntity> listMovieEntity =
          listMovieModel.map((e) => e.toEntity()).toList();
      return Right(listMovieEntity);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies() async {
    try {
      final List<MovieModel> listMovieModel =
          await movieRemoteDataSource.getTrendingMovies();
      final List<MovieEntity> listMovieEntity =
          listMovieModel.map((e) => e.toEntity()).toList();
      return Right(listMovieEntity);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query) async {
    try {
      final List<MovieModel> listMovieModel =
          await movieRemoteDataSource.searchMovies(query);
      final List<MovieEntity> listMovieEntity =
          listMovieModel.map((e) => e.toEntity()).toList();
      return Right(listMovieEntity);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
