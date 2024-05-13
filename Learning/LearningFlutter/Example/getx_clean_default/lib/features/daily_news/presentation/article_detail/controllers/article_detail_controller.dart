import 'package:get/get.dart';
import '../../../domain/usecases/save_article_usecase.dart';

import '../../../domain/entities/article_entity.dart';

class ArticleDetailController extends GetxController {
  final ArticleEntity article = Get.arguments;

  final SaveArticleUseCase _saveArticleUseCase;

  ArticleDetailController(this._saveArticleUseCase);

  void onSaveArticle() async {
    await _saveArticleUseCase(params: article);
  }
}
