import 'package:get/get.dart';

import '../../../../../core/utils/helpers/injection.dart';
import '../../../domain/usecases/get_article_usecase.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      HomeController(getIt.get<GetArticleUseCase>()),
    );
  }
}
