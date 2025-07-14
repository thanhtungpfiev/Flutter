import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:ecommerce_clone/core/configs/theme/app_theme.dart';
import 'package:ecommerce_clone/firebase_options.dart';
import 'package:ecommerce_clone/presentation/splash/bloc/splash_cubit.dart';
import 'package:ecommerce_clone/presentation/splash/pages/splash_page.dart';
import 'package:ecommerce_clone/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set Firebase Auth persistence for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Note: setPersistence() is only supported on web platforms
    // Firebase Auth automatically handles persistence on desktop platforms

    await DesktopWindow.setWindowSize(
      const Size(520, 900),
    ); // iPhone 14 Pro size
    await DesktopWindow.setMinWindowSize(const Size(520, 900));
    await DesktopWindow.setMaxWindowSize(const Size(520, 900));
  }
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashCubit>()..appStarted(),
      child: MaterialApp(
        title: 'Ecommerce Clone',
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}
