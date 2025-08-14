import 'package:ecommerce_clone_getx/app/domain/category/entities/category_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/category/usecases/get_categories_usecase.dart';
import 'package:get/get.dart';

enum CategoriesDisplayState { initial, loading, success, error }

class CategoriesDisplayController extends GetxController {
  CategoriesDisplayController({required this.getCategoriesUseCase});

  final GetCategoriesUseCase getCategoriesUseCase;

  var state = CategoriesDisplayState.initial.obs;
  var categories = <CategoryEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    displayCategories();
  }

  void displayCategories() async {
    state.value = CategoriesDisplayState.loading;
    var returnedData = await getCategoriesUseCase.call();
    returnedData.fold(
      (error) {
        state.value = CategoriesDisplayState.error;
      },
      (data) {
        state.value = CategoriesDisplayState.success;
        categories.assignAll(data);
      },
    );
  }
}
