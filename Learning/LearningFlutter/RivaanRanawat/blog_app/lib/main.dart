import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/app_logger.dart';
import 'package:blog_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:blog_app/features/auth/presentation/pages/auth_gate.dart';
import 'package:blog_app/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:blog_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize logging first, before any other operations
  await initializeDependencies();

  // Also write the higher-level AppLogger message and flush both
  AppLogger.i('Dependencies initialized, starting app');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Your Figma design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(
              create: (_) {
                final cubit = sl<AuthCubit>();
                cubit.getCurrentUser();
                return cubit;
              },
            ),
            BlocProvider<BlogCubit>(create: (_) => sl<BlogCubit>()),
          ],
          child: MaterialApp(
            title: 'Blog App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkThemeMode,
            home: const AuthGate(),
          ),
        );
      },
    );
  }
}
