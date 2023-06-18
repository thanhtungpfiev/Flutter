import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/app_logger.dart';
import 'auth_controller.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  final user = Rxn<User?>();
  final authController = Get.find<AuthController>();

  @override
  void onReady() {
    super.onReady();
    user.value = authController.getUser();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    authController.signOut();
  }

  void signIn() {}

  void website() {
    _launch(Uri.parse("https://github.com/"));
  }

  void facebook() {
    _launch(Uri.parse("https://facebook.com/"));
  }

  void email() {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'cuongphong2508@gmail.com',
    );
    _launch(emailLaunchUri);
  }

  Future<void> _launch(Uri url) async {
    if (await canLaunchUrl(url)) {
      AppLogger.logger.d(url);
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('could not launch $url');
    }
  }
}
