import 'package:ecommerce_clone_getx/app/presentation/auth/pages/signin_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/splash/binding/splash_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/splash/pages/splash_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(name: Routes.signin, page: () => const SigninPage()),
  ];
}
