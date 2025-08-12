import 'package:ecommerce_clone_getx/app/domain/category/entities/category_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/category/usecases/get_categories_usecase.dart';
import 'package:get/get.dart';

enum CategoriesDisplayStatus { initial, loading, success, error }

class CategoriesDisplayController extends GetxController {
  CategoriesDisplayController({required this.getCategoriesUseCase});

  final GetCategoriesUseCase getCategoriesUseCase;

  var status = CategoriesDisplayStatus.initial.obs;
  var categories = <CategoryEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    displayCategories();
  }

  void displayCategories() async {
    status.value = CategoriesDisplayStatus.loading;
    var returnedData = await getCategoriesUseCase.call();
    returnedData.fold(
      (error) {
        status.value = CategoriesDisplayStatus.error;
      },
      (data) {
        status.value = CategoriesDisplayStatus.success;
        categories.assignAll(data);
      },
    );
  }
}
