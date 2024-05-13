import 'package:auto_route/auto_route.dart';

import 'package:clean_architecture_v2/src/presentation/views/breaking_news_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: BreakingNewsRoute.page, initial: true),
        // AutoRoute(page: ArticleDetailsView),
        // AutoRoute(page: SavedArticlesView),
      ];
}

final appRouter = AppRouter();
