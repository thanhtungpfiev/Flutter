import 'package:get/get.dart';

import '../../../../../core/utils/helpers/injection.dart';
import '../../../domain/usecases/get_saved_article_usecase.dart';
import '../../../domain/usecases/remove_article_usecase.dart';
import '../controllers/saved_articles_controller.dart';

class SavedArticlesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SavedArticlesController(
        getIt.get<GetSavedArticleUseCase>(),
        getIt.get<RemoveArticleUseCase>()));
  }
}
