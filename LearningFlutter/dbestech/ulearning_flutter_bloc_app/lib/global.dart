import 'package:firebase_core/firebase_core.dart';

import 'common/services/storage_service.dart';
import 'firebase_options.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();
  }
}
