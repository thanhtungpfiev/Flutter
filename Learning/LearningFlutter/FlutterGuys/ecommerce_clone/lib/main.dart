import 'package:ecommerce_clone/core/configs/theme/app_theme.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/core/utils/app_logger.dart';
import 'package:ecommerce_clone/firebase_options.dart';
import 'package:ecommerce_clone/presentation/settings/bloc/theme_cubit.dart';
import 'package:ecommerce_clone/presentation/splash/bloc/splash_cubit.dart';
import 'package:ecommerce_clone/presentation/splash/pages/splash_page.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging first, before any other operations
  await initializeDependencies();

  // Initialize Firebase with proper error handling for desktop
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    AppLogger.i('Firebase initialized successfully');
  } catch (e) {
    AppLogger.e('Firebase initialization error', e);
  }

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
            BlocProvider(create: (context) => sl<SplashCubit>()..appStarted()),
            BlocProvider(create: (context) => sl<ThemeCubit>()),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                title: UIConstants.appTitle,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                debugShowCheckedModeBanner: false,
                home: const SplashPage(),
              );
            },
          ),
        );
      },
    );
  }
}
