import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:ecommerce_clone/core/utils/app_logger.dart';
import 'package:flutter/services.dart';

Future<void> setFullscreenForDesktop() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    try {
      await DesktopWindow.setFullScreen(true);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      AppLogger.i('Fullscreen mode enabled');
    } catch (e) {
      AppLogger.e('Error setting fullscreen', e);
    }
  }
}
