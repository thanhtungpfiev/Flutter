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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set full screen for desktop platforms
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Set to full screen mode
    await DesktopWindow.setFullScreen(true);

    // Also set system UI overlay style to hide status bars (for additional platforms)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
            home: const FullScreenWrapper(child: SplashPage()),
          ),
        );
      },
    );
  }
}

/// Wrapper widget to ensure full screen mode is maintained
class FullScreenWrapper extends StatefulWidget {
  final Widget child;

  const FullScreenWrapper({super.key, required this.child});

  @override
  State<FullScreenWrapper> createState() => _FullScreenWrapperState();
}

class _FullScreenWrapperState extends State<FullScreenWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _ensureFullScreen();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _ensureFullScreen();
    }
  }

  void _ensureFullScreen() {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Re-enable full screen if it was lost
      DesktopWindow.setFullScreen(true);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
