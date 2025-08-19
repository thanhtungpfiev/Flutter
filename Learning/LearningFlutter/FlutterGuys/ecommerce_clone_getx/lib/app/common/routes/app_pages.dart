import 'package:ecommerce_clone_getx/app/presentation/all_categories/pages/all_categories_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/bindings/auth_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/enter_password_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/forgot_password_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/gender_and_age_selection_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/password_reset_email_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/signin_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/auth/pages/signup_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/cart/bindings/cart_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/cart/pages/cart_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/cart/pages/checkout_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/cart/pages/order_placed_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/category_products/bindings/category_products_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/category_products/pages/category_products_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/bindings/home_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/home/pages/home_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/bindings/product_detail_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/product_detail/pages/product_detail_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/search/bindings/search_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/search/pages/search_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/bindings/settings_binding.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/pages/my_favorites_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/pages/settings_page.dart';
import 'package:ecommerce_clone_getx/app/presentation/splash/bindings/splash_binding.dart';
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
    GetPage(
      name: Routes.cart,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
    GetPage(name: Routes.checkout, page: () => CheckOutPage()),
    GetPage(name: Routes.orderPlaced, page: () => const OrderPlacedPage()),
    GetPage(
      name: Routes.myFavorites,
      page: () => const MyFavoritesPage(),
      binding: SettingsBinding(),
    ),
  ];
}
