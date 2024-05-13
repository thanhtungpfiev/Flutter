import 'package:floor/floor.dart';

import 'package:clean_architecture/features/daily_news/domain/entities/article_entity.dart';

@Entity(tableName: 'article', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    int? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) : super(
          id: id,
          author: author,
          title: title,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
          content: content,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    ArticleModel model = ArticleModel(
      id: map['id'] != null ? map['id'] as int : null,
      author: map['author'] != null ? map['title'] as String : '',
      title: map['title'] != null ? map['title'] as String : '',
      description:
          map['description'] != null ? map['description'] as String : '',
      url: map['url'] != null ? map['url'] as String : null,
      urlToImage: map['urlToImage'] != null ? map['urlToImage'] as String : '',
      publishedAt:
          map['publishedAt'] != null ? map['publishedAt'] as String : '',
      content: map['content'] != null ? map['content'] as String : '',
    );
    return model;
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
        id: entity.id,
        author: entity.author,
        title: entity.title,
        description: entity.description,
        url: entity.url,
        urlToImage: entity.urlToImage,
        publishedAt: entity.publishedAt,
        content: entity.content);
  }
}
