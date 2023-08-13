import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/theme/theme_app.dart';
import 'app/core/utils/helpers/shared_preferences_helper.dart';
import 'app/core/utils/helpers/theme_helper.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  Get.put(ThemeHelper());

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      themeMode: Get.put(ThemeHelper()).getThemeMode(),
      theme: ThemeApp.light,
      darkTheme: ThemeApp.dark,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
