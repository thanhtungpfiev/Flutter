import 'package:clean_architecture/core/network/data_state.dart';
import 'package:clean_architecture/features/daily_news/domain/entities/article_entity.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> saveArticle(ArticleEntity articleEntity);

  Future<void> removeArticle(ArticleEntity articleEntity);
}
