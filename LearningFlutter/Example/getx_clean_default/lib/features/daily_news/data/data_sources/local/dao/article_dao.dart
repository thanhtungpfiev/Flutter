import 'package:floor/floor.dart';
import '../../../../../../core/configs/constants/db_constants.dart';
import '../../../models/article_model.dart';

@dao
abstract class ArticleDao {
  @Insert()
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query('SELECT * FROM $articleTable')
  Future<List<ArticleModel>> getArticles();
}
