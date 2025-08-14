import 'package:ecommerce_clone_getx/app/core/services/app_logging_service.dart';
import 'package:ecommerce_clone_getx/app/core/services/logging_service.dart';
import 'package:ecommerce_clone_getx/app/data/auth/data_sources/auth_firebase_service.dart';
import 'package:ecommerce_clone_getx/app/data/auth/data_sources/auth_service.dart';
import 'package:ecommerce_clone_getx/app/data/auth/repositories/auth_repository_impl.dart';
import 'package:ecommerce_clone_getx/app/data/category/data_sources/category_firebase_service.dart';
import 'package:ecommerce_clone_getx/app/data/category/data_sources/category_service.dart';
import 'package:ecommerce_clone_getx/app/data/category/repositories/category_repository_impl.dart';
import 'package:ecommerce_clone_getx/app/data/order/data_sources/order_firebase_service.dart';
import 'package:ecommerce_clone_getx/app/data/order/data_sources/order_service.dart';
import 'package:ecommerce_clone_getx/app/data/order/repositories/order_repository_impl.dart';
import 'package:ecommerce_clone_getx/app/data/product/data_sources/product_firebase_service.dart';
import 'package:ecommerce_clone_getx/app/data/product/data_sources/product_service.dart';
import 'package:ecommerce_clone_getx/app/data/product/repositories/product_repository_impl.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/repositories/auth_repository.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/get_ages_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/get_user_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/is_logged_in_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/send_password_reset_email_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/signin_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/signout_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/signup_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/category/repositories/category_repository.dart';
import 'package:ecommerce_clone_getx/app/domain/category/usecases/get_categories_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/order/repository/order_repository.dart';
import 'package:ecommerce_clone_getx/app/domain/order/usecases/add_to_cart_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/repositories/product_repository.dart';
import 'package:ecommerce_clone_getx/app/domain/product/usecases/get_new_in_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/usecases/get_products_by_category_id_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/usecases/get_products_by_title_usecase.dart';
import 'package:ecommerce_clone_getx/app/domain/product/usecases/get_top_selling_usecase.dart';
import 'package:ecommerce_clone_getx/app/presentation/settings/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Initialize logging first
  await AppLoggingService.initialize();

  // Services
  // Logging
  sl.registerSingleton<LoggingService>(AppLoggingService.instance);
  // Auth
  sl.registerSingleton<AuthService>(AuthFirebaseService());
  // Category
  sl.registerSingleton<CategoryService>(CategoryFirebaseService());
  // Product
  sl.registerSingleton<ProductService>(ProductFirebaseService());
  // Order
  sl.registerSingleton<OrderService>(OrderFirebaseService());

  // Repositories
  // Auth
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(authService: sl()));
  // Category
  sl.registerSingleton<CategoryRepository>(
    CategoryRepositoryImpl(categoryService: sl()),
  );
  // Product
  sl.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(productService: sl()),
  );
  // Order
  sl.registerSingleton<OrderRepository>(
    OrderRepositoryImpl(orderService: sl()),
  );

  // Usecases
  // Auth
  sl.registerSingleton<SignupUseCase>(SignupUseCase(authRepository: sl()));
  sl.registerSingleton<SigninUseCase>(SigninUseCase(authRepository: sl()));
  sl.registerSingleton<GetAgesUseCase>(GetAgesUseCase(authRepository: sl()));
  sl.registerSingleton<SendPasswordResetEmailUseCase>(
    SendPasswordResetEmailUseCase(authRepository: sl()),
  );
  sl.registerSingleton<IsLoggedInUseCase>(
    IsLoggedInUseCase(authRepository: sl()),
  );
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase(authRepository: sl()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(authRepository: sl()));
  // Category
  sl.registerSingleton<GetCategoriesUseCase>(
    GetCategoriesUseCase(categoryRepository: sl()),
  );
  // Product
  sl.registerSingleton<GetTopSellingUseCase>(
    GetTopSellingUseCase(productRepository: sl()),
  );
  sl.registerSingleton<GetNewInUseCase>(
    GetNewInUseCase(productRepository: sl()),
  );
  sl.registerSingleton<GetProductsByCategoryIdUseCase>(
    GetProductsByCategoryIdUseCase(productRepository: sl()),
  );
  sl.registerSingleton<GetProductsByTitleUseCase>(
    GetProductsByTitleUseCase(productRepository: sl()),
  );
  // sl.registerSingleton<IsFavoriteUseCase>(
  //   IsFavoriteUseCase(productRepository: sl()),
  // );
  // sl.registerSingleton<AddOrRemoveFavoriteProductUseCase>(
  //   AddOrRemoveFavoriteProductUseCase(productRepository: sl()),
  // );
  // sl.registerSingleton<GetFavoritesProductsUseCase>(
  //   GetFavoritesProductsUseCase(productRepository: sl()),
  // );
  // Order
  sl.registerSingleton<AddToCartUseCase>(
    AddToCartUseCase(orderRepository: sl()),
  );
  // sl.registerSingleton<GetCartProductsUseCase>(
  //   GetCartProductsUseCase(orderRepository: sl()),
  // );
  // sl.registerSingleton<RemoveCartProductUseCase>(
  //   RemoveCartProductUseCase(orderRepository: sl()),
  // );
  // sl.registerSingleton<OrderRegistrationUseCase>(
  //   OrderRegistrationUseCase(orderRepository: sl()),
  // );
  // sl.registerSingleton<GetOrdersUseCase>(
  //   GetOrdersUseCase(orderRepository: sl()),
  // );

  // Controllers
  // Theme
  Get.put(ThemeController());
}
