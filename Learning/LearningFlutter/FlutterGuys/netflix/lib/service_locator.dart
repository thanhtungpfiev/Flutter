import 'package:get_it/get_it.dart';
import 'package:netflix/core/network/dio_client.dart';
import 'package:netflix/data/auth/datasources/auth_service.dart';
import 'package:netflix/data/auth/repositories/auth_repository_impl.dart';
import 'package:netflix/data/movie/datasources/movie_service.dart';
import 'package:netflix/data/movie/repositories/movie_repository_impl.dart';
import 'package:netflix/domain/auth/repositories/auth_repository.dart';
import 'package:netflix/domain/auth/usecases/is_logged_in_usecase.dart';
import 'package:netflix/domain/auth/usecases/signin_usecase.dart';
import 'package:netflix/domain/auth/usecases/signup_usecase.dart';
import 'package:netflix/domain/movie/repositories/movie_repository.dart';
import 'package:netflix/domain/movie/usecases/get_trending_movies_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthService>(AuthServiceApiImpl());
  sl.registerSingleton<MovieService>(MovieServiceApiImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<MovieRepository>(MovieRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
  sl.registerSingleton<GetTrendingMoviesUseCase>(GetTrendingMoviesUseCase());
}
