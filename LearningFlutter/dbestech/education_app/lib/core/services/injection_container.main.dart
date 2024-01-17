part of 'injection_container.dart';

final sl = GetIt.instance;
Future<void> init() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _initOnBoarding();

  await _initAuthentication();
}

Future<void> _initAuthentication() async {
  sl
    ..registerFactory(() => AuthenticationBloc(sl(), sl(), sl(), sl()))
    ..registerLazySingleton(() => SignUpUseCase(sl()))
    ..registerLazySingleton(() => SignInUseCase(sl()))
    ..registerLazySingleton(() => ForgotPasswordUseCase(sl()))
    ..registerLazySingleton(() => UpdateUserUseCase(sl()))
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl()),
    )
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _initOnBoarding() async {
  final pref = await SharedPreferences.getInstance();
  sl
    ..registerFactory(() => OnBoardingCubit(sl(), sl()))
    ..registerLazySingleton(() => CacheFirstTimerUseCase(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimerUseCase(sl()))
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepositoryImpl(sl()),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton(() => pref);
}
