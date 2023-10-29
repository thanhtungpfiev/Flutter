import 'package:get/get.dart';
import 'package:getx_clean_default/features/daily_news/domain/usecases/remove_article_usecase.dart';

import '../../../domain/entities/article_entity.dart';
import '../../../domain/usecases/get_saved_article_usecase.dart';

class SavedArticlesController extends GetxController {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  final isLoading = true.obs;
  final articleEntityList = <ArticleEntity>[].obs;

  SavedArticlesController(
      this._getSavedArticleUseCase, this._removeArticleUseCase);

  @override
  void onReady() {
    super.onReady();
    onGetSavedArticles();
  }

  void onGetSavedArticles() async {
    isLoading.value = true;
    articleEntityList.value = await _getSavedArticleUseCase();
    isLoading.value = false;
  }

  void onRemoveArticle(ArticleEntity article) async {
    isLoading.value = true;
    await _removeArticleUseCase(params: article);
    articleEntityList.value = await _getSavedArticleUseCase();
    isLoading.value = false;
  }
}
