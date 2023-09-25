// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture/features/daily_news/domain/entities/article_entity.dart';

abstract class LocalArticleEvent {
  final ArticleEntity? articleEntity;

  const LocalArticleEvent({this.articleEntity});

  @override
  bool operator ==(covariant LocalArticleEvent other) {
    if (identical(this, other)) return true;

    return other.articleEntity == articleEntity;
  }

  @override
  int get hashCode => articleEntity.hashCode;
}

class GetSavedArticles extends LocalArticleEvent {
  const GetSavedArticles();
}

class RemoveArticle extends LocalArticleEvent {
  const RemoveArticle(ArticleEntity articleEntity)
      : super(articleEntity: articleEntity);
}

class SaveArticle extends LocalArticleEvent {
  const SaveArticle(ArticleEntity articleEntity)
      : super(articleEntity: articleEntity);
}
