import 'package:floor/floor.dart';

import 'package:clean_architecture/features/daily_news/data/data_sources/local/DAO/article_dao.dart';
import 'package:clean_architecture/features/daily_news/data/models/article_model.dart';

@dao
abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel articleModel);

  @delete
  Future<void> deleteArticle(ArticleModel articleModel);

  @Query('SELECT * from article')
  Future<List<ArticleModel>> getArticleList();
}
