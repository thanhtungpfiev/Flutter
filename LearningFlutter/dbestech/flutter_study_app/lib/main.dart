import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/firebase_options.dart';
import 'package:get/get.dart';

import 'screens/data_uploader_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(GetMaterialApp(
    home: DataUploaderScreen(),
  ));
}
