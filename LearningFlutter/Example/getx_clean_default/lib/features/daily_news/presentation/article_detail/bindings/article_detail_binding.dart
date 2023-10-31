import 'package:get/get.dart';

import '../../../../../core/utils/helpers/injection.dart';
import '../../../domain/usecases/save_article_usecase.dart';
import '../controllers/article_detail_controller.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticleDetailController>(
        () => ArticleDetailController(getIt.get<SaveArticleUseCase>()));
  }
}
