import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/core/services/app_logging_service.dart';
import 'package:blog_app/core/services/logging_service.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_data_source_impl.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:blog_app/features/auth/presentation/blocs/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Initialize logging first
  await AppLoggingService.initialize();

  // Services
  // Logging
  sl.registerSingleton<LoggingService>(AppLoggingService.instance);
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

  // Repositories
  // Auth
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(authDataSource: sl()),
  );

  // Usecases
  // Auth
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(authRepository: sl()));
  sl.registerSingleton<SignInUseCase>(SignInUseCase(authRepository: sl()));

  // Blocs
  sl.registerFactory(() => AuthCubit(signUpUseCase: sl(), signInUseCase: sl()));
}
