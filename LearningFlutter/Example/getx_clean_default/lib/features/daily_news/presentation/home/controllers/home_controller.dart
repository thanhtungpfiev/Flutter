import 'package:get/get.dart';

import '../../../../../core/resources/data_state.dart';
import '../../../domain/usecases/get_article_usecase.dart';

class HomeController extends GetxController {
  final GetArticleUseCase _getArticleUseCase;
  final isDataSuccess = false.obs;
  final isLoading = true.obs;
  final articleEntityList = [].obs;

  HomeController(this._getArticleUseCase);

  @override
  void onInit() {
    super.onInit();
    onGetArticles();
  }

  void onGetArticles() async {
    isLoading.value = true;
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      isDataSuccess.value = true;
      articleEntityList.value = dataState.data!;
    } else {
      isDataSuccess.value = false;
    }
    isLoading.value = false;
  }
}
