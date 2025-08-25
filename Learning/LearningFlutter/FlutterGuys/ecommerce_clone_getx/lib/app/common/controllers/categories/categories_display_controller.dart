import 'package:ecommerce_clone_getx/app/domain/category/entities/category_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/category/usecases/get_categories_usecase.dart';
import 'package:get/get.dart';

enum CategoriesDisplayState { initial, loading, success, error }

class CategoriesDisplayController extends GetxController {
  CategoriesDisplayController({required this.getCategoriesUseCase});

  final GetCategoriesUseCase getCategoriesUseCase;

  final state = CategoriesDisplayState.initial.obs;
  final categories = <CategoryEntity>[].obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    displayCategories();
  }

  void displayCategories() async {
    state.value = CategoriesDisplayState.loading;
    errorMessage.value = '';
    var returnedData = await getCategoriesUseCase.call();
    returnedData.fold(
      (error) {
        state.value = CategoriesDisplayState.error;
        errorMessage.value = error;
        categories.clear();
      },
      (data) {
        state.value = CategoriesDisplayState.success;
        errorMessage.value = '';
        categories.assignAll(data);
      },
    );
  }
}
