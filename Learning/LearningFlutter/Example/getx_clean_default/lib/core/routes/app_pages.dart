import 'package:get/get.dart';

import '../../features/daily_news/presentation/article_detail/bindings/article_detail_binding.dart';
import '../../features/daily_news/presentation/article_detail/views/article_detail_view.dart';
import '../../features/daily_news/presentation/home/bindings/home_binding.dart';
import '../../features/daily_news/presentation/home/views/home_view.dart';
import '../../features/daily_news/presentation/saved_articles/bindings/saved_articles_binding.dart';
import '../../features/daily_news/presentation/saved_articles/views/saved_articles_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.articleDetail,
      page: () => const ArticleDetailView(),
      binding: ArticleDetailBinding(),
    ),
    GetPage(
      name: _Paths.savedArticles,
      page: () => const SavedArticlesView(),
      binding: SavedArticlesBinding(),
    ),
  ];
}
