import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/errors/server_exception.dart';
import 'package:movie_app/core/errors/server_failure.dart';
import 'package:movie_app/data/datasources/remote/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])
void main() {
  late MovieRepository movieRepositoryImpl;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    movieRepositoryImpl =
        MovieRepositoryImpl(movieRemoteDataSource: mockMovieRemoteDataSource);
  });

  final tMovieLModelList = [
    const MovieModel(
        id: 1,
        title: 'title 1',
        overview: 'overview 1',
        posterPath: 'posterPath1'),
    const MovieModel(
        id: 2,
        title: 'title 2',
        overview: 'overview 2',
        posterPath: 'posterPath2'),
  ];

  final tMovieList = [
    const MovieEntity(
        id: 1,
        title: 'title 1',
        overview: 'overview 1',
        posterPath: 'posterPath1'),
    const MovieEntity(
        id: 2,
        title: 'title 2',
        overview: 'overview 2',
        posterPath: 'posterPath2'),
  ];

  const tQuery = 'Inception';

  test('should get trending movies from the remote data source', () async {
    // arrange
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenAnswer((realInvocation) async => tMovieLModelList);

    // act
    final result = await movieRepositoryImpl.getTrendingMovies();

    // assert
    verify(mockMovieRemoteDataSource.getTrendingMovies());
    expect(result, isA<Right<Failure, List<MovieEntity>>>());
  });

  test('should get popular movies from the remote data source', () async {
    // arrange
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenAnswer((realInvocation) async => tMovieLModelList);

    // act
    final result = await movieRepositoryImpl.getPopularMovies();

    // assert
    verify(mockMovieRemoteDataSource.getPopularMovies());
    expect(result, isA<Right<Failure, List<MovieEntity>>>());
  });

  test('should search movies from the remote data source', () async {
    // arrange
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenAnswer((realInvocation) async => tMovieLModelList);

    // act
    final result = await movieRepositoryImpl.searchMovies(tQuery);

    // assert
    verify(mockMovieRemoteDataSource.searchMovies(tQuery));
    expect(result, isA<Right<Failure, List<MovieEntity>>>());
  });

  test(
      'should return ServerFailure for trending when the call to the remote data source is unsuccessfully',
      () async {
    // arrange
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenThrow(ServerException());

    // act
    final result = await movieRepositoryImpl.getTrendingMovies();

    // assert
    verify(mockMovieRemoteDataSource.getTrendingMovies());
    expect(result, isA<Left<Failure, List<MovieEntity>>>());
  });

  test(
      'should return ServerFailure for popular when the call to the remote data source is unsuccessfully',
      () async {
    // arrange
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenThrow(ServerException());

    // act
    final result = await movieRepositoryImpl.getPopularMovies();

    // assert
    verify(mockMovieRemoteDataSource.getPopularMovies());
    expect(result, isA<Left<Failure, List<MovieEntity>>>());
  });

  test(
      'should return ServerFailure for search when the call to the remote data source is unsuccessfully',
      () async {
    // arrange
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenThrow(ServerException());

    // act
    final result = await movieRepositoryImpl.searchMovies(tQuery);

    // assert
    verify(mockMovieRemoteDataSource.searchMovies(tQuery));
    expect(result, isA<Left<Failure, List<MovieEntity>>>());
  });
}
