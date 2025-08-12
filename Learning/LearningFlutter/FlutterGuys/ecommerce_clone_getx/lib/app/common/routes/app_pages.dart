import 'package:ecommerce_clone_getx/app/presentation/all_categories/pages/all_categories_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/binding/auth_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/enter_password_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/forgot_password_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/gender_and_age_selection_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/password_reset_email_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/signin_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/signup_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/category_products/binding/category_products_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/category_products/pages/category_products_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/binding/home_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/pages/home_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/binding/product_detail_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/pages/product_detail_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/search/binding/search_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/search/pages/search_page.dart';
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
    GetPage(name: Routes.signup, page: () => const SignupPage()),
    GetPage(
      name: Routes.genderAndAgeSelection,
      page: () => const GenderAndAgeSelectionPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(name: Routes.settings, page: () => const SettingsPage()),
    GetPage(
      name: Routes.search,
      page: () => const SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.productDetail,
      page: () => const ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
    GetPage(name: Routes.allCategories, page: () => const AllCategoriesPage()),
    GetPage(
      name: Routes.categoryProducts,
      page: () => const CategoryProductsPage(),
      binding: CategoryProductsBinding(),
    ),
  ];
}
