import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/common/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
