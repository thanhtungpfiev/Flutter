import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_cubit.dart';
import 'package:ecommerce_clone/common/blocs/categories/categories_display_cubit.dart';
import 'package:ecommerce_clone/common/blocs/products/products_display_cubit.dart';
import 'package:ecommerce_clone/data/auth/data_sources/auth_firebase_service.dart';
import 'package:ecommerce_clone/data/auth/data_sources/auth_service.dart';
import 'package:ecommerce_clone/data/auth/repositories/auth_repository_impl.dart';
import 'package:ecommerce_clone/data/category/data_sources/category_firebase_service.dart';
import 'package:ecommerce_clone/data/category/data_sources/category_service.dart';
import 'package:ecommerce_clone/data/category/repositories/category_repository_impl.dart';
import 'package:ecommerce_clone/data/product/data_sources/product_firebase_service.dart';
import 'package:ecommerce_clone/data/product/data_sources/product_service.dart';
import 'package:ecommerce_clone/data/product/repositories/product_repository_impl.dart';
import 'package:ecommerce_clone/domain/auth/repositories/auth_repository.dart';
import 'package:ecommerce_clone/domain/auth/usecases/get_ages_usecase.dart';
import 'package:ecommerce_clone/domain/auth/usecases/get_user_usecase.dart';
import 'package:ecommerce_clone/domain/auth/usecases/is_logged_in_usecase.dart';
import 'package:ecommerce_clone/domain/auth/usecases/send_password_reset_email_usecase.dart';
import 'package:ecommerce_clone/domain/auth/usecases/signin_usecase.dart';
import 'package:ecommerce_clone/domain/auth/usecases/signout_usecase.dart';
import 'package:ecommerce_clone/domain/auth/usecases/signup_usecase.dart';
import 'package:ecommerce_clone/domain/category/repositories/category_repository.dart';
import 'package:ecommerce_clone/domain/category/usecases/get_categories_usecase.dart';
import 'package:ecommerce_clone/domain/product/repositories/product_repository.dart';
import 'package:ecommerce_clone/domain/product/usecases/get_new_in_usecase.dart';
import 'package:ecommerce_clone/domain/product/usecases/get_products_by_category_id_usecase.dart';
import 'package:ecommerce_clone/domain/product/usecases/get_products_by_title_usecase.dart';
import 'package:ecommerce_clone/domain/product/usecases/get_top_selling_usecase.dart';
import 'package:ecommerce_clone/presentation/auth/blocs/age_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/auth/blocs/ages_display_cubit.dart';
import 'package:ecommerce_clone/presentation/auth/blocs/gender_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/home/blocs/user_info_display_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:ecommerce_clone/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:ecommerce_clone/presentation/splash/bloc/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Services
  // Auth
  sl.registerSingleton<AuthService>(AuthFirebaseService());
  // Category
  sl.registerSingleton<CategoryService>(CategoryFirebaseService());
  // Product
  sl.registerSingleton<ProductService>(ProductFirebaseService());

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

  // Blocs
  // Common
  sl.registerFactory<BasicReactiveButtonCubit>(
    () => BasicReactiveButtonCubit(),
  );
  // Auth
  sl.registerFactory<SplashCubit>(() => SplashCubit(isLoggedInUseCase: sl()));
  sl.registerFactory<GenderSelectionCubit>(() => GenderSelectionCubit());
  sl.registerFactory<AgeSelectionCubit>(() => AgeSelectionCubit());
  sl.registerFactory<AgesDisplayCubit>(
    () => AgesDisplayCubit(getAgesUseCase: sl()),
  );
  sl.registerFactory<UserInfoDisplayCubit>(
    () => UserInfoDisplayCubit(getUserUseCase: sl()),
  );
  // Category
  sl.registerFactory<CategoriesDisplayCubit>(
    () => CategoriesDisplayCubit(getCategoriesUseCase: sl()),
  );
  // Product
  sl.registerFactory<ProductsDisplayCubit>(
    () => ProductsDisplayCubit(useCase: sl<GetTopSellingUseCase>()),
    instanceName: 'getTopSellingUseCase',
  );
  sl.registerFactory<ProductsDisplayCubit>(
    () => ProductsDisplayCubit(useCase: sl<GetNewInUseCase>()),
    instanceName: 'getNewInUseCase',
  );
  sl.registerFactory<ProductsDisplayCubit>(
    () => ProductsDisplayCubit(useCase: sl<GetProductsByCategoryIdUseCase>()),
    instanceName: 'getProductsByCategoryIdUseCase',
  );
  sl.registerFactory<ProductsDisplayCubit>(
    () => ProductsDisplayCubit(useCase: sl<GetProductsByTitleUseCase>()),
    instanceName: 'getProductsByTitleUseCase',
  );
  // Product Detail
  sl.registerFactory<ProductQuantityCubit>(() => ProductQuantityCubit());
  sl.registerFactory<ProductColorSelectionCubit>(
    () => ProductColorSelectionCubit(),
  );
  sl.registerFactory<ProductSizeSelectionCubit>(
    () => ProductSizeSelectionCubit(),
  );
  // sl.registerFactory<FavoriteIconCubit>(() => FavoriteIconCubit());
}
