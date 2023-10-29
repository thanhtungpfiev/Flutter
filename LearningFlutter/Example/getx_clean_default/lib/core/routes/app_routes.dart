part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const articleDetail = _Paths.articleDetail;
  static const savedArticles = _Paths.savedArticles;
}

abstract class _Paths {
  _Paths._();

  static const home = '/home';
  static const articleDetail = '/article-detail';
  static const savedArticles = '/saved-articles';
}
