import 'package:flutter/material.dart';
import 'package:travo_app/helpers/local_storage_helper.dart';
import 'package:travo_app/representation/screens/main_app_screen.dart';
import '../../helpers/asset_helper.dart';
import '../../helpers/image_helper.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash_screen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirectIntroScreen();
  }

  void redirectIntroScreen() async {
    final ignoreIntroScreen =
        LocalStorageHelper.getValue('ingnoreIntroScreen') as bool?;
    await Future.delayed(const Duration(seconds: 2));
    if (ignoreIntroScreen != null && ignoreIntroScreen) {
      Navigator.of(context).pushNamed(MainAppScreen.routeName);
    } else {
      LocalStorageHelper.setValue('ingnoreIntroScreen', true);
      Navigator.of(context).pushNamed(IntroScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageHelper.loadFromAssets(
            AssetHelper.imageBackgroundSplash,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned.fill(
          child: ImageHelper.loadFromAssets(
            AssetHelper.imageCircleSplash,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
