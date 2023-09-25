import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:clean_architecture/features/daily_news/domain/entities/article_entity.dart';

abstract class LocalArticlesState {
  final List<ArticleEntity>? articles;

  const LocalArticlesState({this.articles});

  @override
  bool operator ==(covariant LocalArticlesState other) {
    if (identical(this, other)) return true;

    return listEquals(other.articles, articles);
  }

  @override
  int get hashCode => articles.hashCode;
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesDone extends LocalArticlesState {
  const LocalArticlesDone(List<ArticleEntity> articles)
      : super(articles: articles);
}
