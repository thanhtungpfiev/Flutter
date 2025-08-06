import 'package:ecommerce_clone_getx/app/presentation/auth/pages/enter_password_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/forgot_password_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/password_reset_email_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/signin_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/binding/home_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/pages/home_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/pages/settings_page.dart';
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
    GetPage(name: Routes.enterPassword, page: () => const EnterPasswordPage()),
    GetPage(name: Routes.forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(
      name: Routes.passwordResetEmail,
      page: () => const PasswordResetEmailPage(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(name: Routes.settings, page: () => const SettingsPage()),
  ];
}
