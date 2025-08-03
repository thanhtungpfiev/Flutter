import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:ecommerce_clone/core/configs/theme/app_theme.dart';
import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:ecommerce_clone/firebase_options.dart';
import 'package:ecommerce_clone/presentation/splash/bloc/splash_cubit.dart';
import 'package:ecommerce_clone/presentation/splash/pages/splash_page.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with proper error handling for desktop
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  // Set fullscreen immediately for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    try {
      await DesktopWindow.setFullScreen(true);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      print('Fullscreen mode enabled');
    } catch (e) {
      print('Error setting fullscreen: $e');
    }
  }

  await initializeDependencies();
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
        return BlocProvider(
          create: (context) => sl<SplashCubit>()..appStarted(),
          child: MaterialApp(
            title: UIConstants.appTitle,
            theme: AppTheme.appTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashPage(),
          ),
        );
      },
    );
  }
}
