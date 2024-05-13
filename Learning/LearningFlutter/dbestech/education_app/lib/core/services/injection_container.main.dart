part of 'injection_container.dart';

final sl = GetIt.instance;
Future<void> init() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _initOnBoarding();

  await _initAuthentication();

  await _initCourse();
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

Future<void> _initCourse() async {
  sl
    ..registerFactory(() => CourseCubit(sl(), sl()))
    ..registerLazySingleton(() => AddCourseUseCase(sl()))
    ..registerLazySingleton(() => GetCoursesUseCase(sl()))
    ..registerLazySingleton<CourseRepository>(
      () => CourseRepositoryImpl(sl()),
    )
    ..registerLazySingleton<CourseRemoteDataSource>(
      () => CourseRemoteDataSourceImpl(
        firebaseFirestore: sl(),
        firebaseStorage: sl(),
        firebaseAuth: sl(),
      ),
    );
}
