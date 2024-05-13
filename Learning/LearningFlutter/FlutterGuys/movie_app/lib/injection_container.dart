import 'package:get_it/get_it.dart';

import 'data/datasources/remote/movie_remote_data_source.dart';
import 'data/datasources/remote/movie_remote_data_source_impl.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/get_popular_movies_usecase.dart';
import 'domain/usecases/get_trending_movies_usecase.dart';
import 'domain/usecases/search_movies_usecase.dart';
import 'presentation/blocs/popular_movie/popular_movie_bloc.dart';
import 'presentation/blocs/search_movie/search_movie_bloc.dart';
import 'presentation/blocs/trending_movie/trending_movie_bloc.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void init() {
  // Bloc
  getIt.registerFactory(
      () => PopularMovieBloc(getPopularMoviesUseCase: getIt()));
  getIt.registerFactory(
      () => TrendingMovieBloc(getTrendingMoviesUseCase: getIt()));
  getIt.registerFactory(() => SearchMovieBloc(searchMoviesUseCase: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetPopularMoviesUseCase(getIt()));
  getIt.registerLazySingleton(() => GetTrendingMoviesUseCase(getIt()));
  getIt.registerLazySingleton(() => SearchMoviesUseCase(getIt()));

  // Repositories
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(movieRemoteDataSource: getIt()));

  // Data sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: getIt()));

  // Http services
  getIt.registerLazySingleton(() => http.Client());
}
