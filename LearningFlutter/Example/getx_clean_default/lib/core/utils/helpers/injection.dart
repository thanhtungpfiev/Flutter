import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../features/daily_news/data/data_sources/local/app_database.dart';
import '../../../features/daily_news/data/data_sources/remote/news_api_service.dart';
import '../../../features/daily_news/data/repositories/article_repository_impl.dart';
import '../../../features/daily_news/domain/repositories/article_repository.dart';
import '../../../features/daily_news/domain/usecases/get_article_usecase.dart';
import '../../../features/daily_news/domain/usecases/get_saved_article_usecase.dart';
import '../../../features/daily_news/domain/usecases/remove_article_usecase.dart';
import '../../../features/daily_news/domain/usecases/save_article_usecase.dart';
import '../../configs/constants/db_constants.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final database = await $FloorAppDatabase.databaseBuilder(dbName).build();
  getIt.registerSingleton<AppDatabase>(database);

  // Dio
  getIt.registerSingleton<Dio>(Dio());
  // getIt.get<Dio>().interceptors.add(AwesomeDioInterceptor());

  // Dependencies
  getIt.registerSingleton<NewsApiService>(NewsApiService(getIt()));

  getIt.registerSingleton<ArticleRepository>(
      ArticleRepositoryImpl(getIt(), getIt()));

  //UseCases
  getIt.registerSingleton<GetArticleUseCase>(GetArticleUseCase(getIt()));
  getIt.registerSingleton<GetSavedArticleUseCase>(
      GetSavedArticleUseCase(getIt()));
  getIt.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(getIt()));
  getIt.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(getIt()));
}
