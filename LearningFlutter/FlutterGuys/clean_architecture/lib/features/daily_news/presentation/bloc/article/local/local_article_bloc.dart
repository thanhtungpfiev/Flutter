import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_architecture/features/daily_news/domain/usecases/get_saved_article_usecase.dart';
import 'package:clean_architecture/features/daily_news/domain/usecases/remove_article_usecase.dart';
import 'package:clean_architecture/features/daily_news/domain/usecases/save_article_usecase.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc(this._getSavedArticleUseCase, this._saveArticleUseCase,
      this._removeArticleUseCase)
      : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onRemoveArticle(
      RemoveArticle removeArticle, Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removeArticle.articleEntity);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(params: saveArticle.articleEntity);
    final articles =
        await _getSavedArticleUseCase(params: saveArticle.articleEntity);
    emit(LocalArticlesDone(articles));
  }
}
