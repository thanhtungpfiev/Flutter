import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/services/storage_service.dart';
import 'common/utils/bloc_observer.dart';
import 'firebase_options.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    Bloc.observer = MyGlobalObserver();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();
  }
}
