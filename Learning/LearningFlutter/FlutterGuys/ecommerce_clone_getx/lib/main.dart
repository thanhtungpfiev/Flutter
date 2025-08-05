import 'package:ecommerce_clone_getx/app/core/configs/theme/app_theme.dart';
import 'package:ecommerce_clone_getx/app/core/constants/ui_constants.dart';
import 'package:ecommerce_clone_getx/app/core/utils/app_logger.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/controllers/theme_controller.dart';
import 'package:ecommerce_clone_getx/firebase_options.dart';
import 'package:ecommerce_clone_getx/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/common/routes/app_pages.dart';

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

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844), // Your Figma design size
      minTextAdapt: true,
      splitScreenMode: true,
      child: Obx(
        () => GetMaterialApp(
          title: UIConstants.appTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: Get.find<ThemeController>().themeMode.value,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
        ),
      ),
    ),
  );
}
