import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:clean_architecture/features/daily_news/data/repository_impl/article_repository_impl.dart';
import 'package:clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_architecture/features/daily_news/domain/usecases/get_article_usecase.dart';
import 'package:clean_architecture/features/daily_news/domain/usecases/get_saved_article_usecase.dart';
import 'package:clean_architecture/features/daily_news/domain/usecases/remove_article_usecase.dart';
import 'package:clean_architecture/features/daily_news/domain/usecases/save_article_usecase.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future initializeDependencies() async {
  final database =
      await $FloorAppDatase.databaseBuilder('app_database.db').build();

  sl.registerSingleton(database);

  sl.registerSingleton(Dio());

  sl.registerSingleton(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  sl.registerSingleton(GetArticleUseCase(sl()));

  sl.registerSingleton(GetSavedArticleUseCase(sl()));

  sl.registerSingleton(SaveArticleUseCase(sl()));

  sl.registerSingleton(RemoveArticleUseCase(sl()));

  sl.registerFactory(() => RemoteArticlesBloc(sl()));

  sl.registerFactory(() => LocalArticleBloc(sl(), sl(), sl()));
}
