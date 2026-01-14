import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/core/services/app_user/app_user_service.dart';
import 'package:blog_app/core/services/logging/app_logging_service.dart';
import 'package:blog_app/core/services/logging/logging_service.dart';
import 'package:blog_app/core/services/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_data_source_impl.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:blog_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_source_impl.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:blog_app/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Initialize logging first
  await AppLoggingService.initialize();

  // Services
  // Logging
  sl.registerSingleton<LoggingService>(AppLoggingService.instance);
  // App-level user service
  sl.registerSingleton<AppUserService>(AppUserService());
  // Network
  sl.registerSingleton(InternetConnection());
  sl.registerSingleton<ConnectionChecker>(
    ConnectionCheckerImpl(internetConnection: sl()),
  );
  // Auth
  // Initialize Supabase (supabase_flutter provides AsyncStorage for gotrue)
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  // Register Supabase client from Supabase Flutter package
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  sl.registerSingleton<AuthDataSource>(
    AuthDataSourceImpl(supabaseClient: sl()),
  );

  // Blog
  sl.registerSingleton<BlogRemoteDataSource>(
    BlogRemoteDataSourceImpl(supabaseClient: sl()),
  );

  // Repositories
  // Auth
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(authDataSource: sl(), connectionChecker: sl()),
  );

  // Blog
  sl.registerSingleton<BlogRepository>(
    BlogRepositoryImpl(blogRemoteDataSource: sl(), connectionChecker: sl()),
  );

  // Usecases
  // Auth
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(authRepository: sl()));
  sl.registerSingleton<SignInUseCase>(SignInUseCase(authRepository: sl()));
  sl.registerSingleton<GetCurrentUserUseCase>(
    GetCurrentUserUseCase(authRepository: sl()),
  );

  // Blog
  sl.registerSingleton<UploadBlogUseCase>(
    UploadBlogUseCase(blogRepository: sl()),
  );
  sl.registerSingleton<GetAllBlogsUseCase>(
    GetAllBlogsUseCase(blogRepository: sl()),
  );

  // Blocs
  // Auth
  sl.registerFactory(
    () => AuthCubit(
      signUpUseCase: sl(),
      signInUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );

  // Blog
  sl.registerFactory(
    () => BlogCubit(uploadBlogUseCase: sl(), getAllBlogsUseCase: sl()),
  );
}
