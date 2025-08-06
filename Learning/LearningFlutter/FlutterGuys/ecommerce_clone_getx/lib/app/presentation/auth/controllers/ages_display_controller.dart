import 'package:ecommerce_clone_getx/app/domain/auth/usecases/get_ages_usecase.dart';
import 'package:get/get.dart';

class AgesDisplayController extends GetxController {
  AgesDisplayController({required this.getAgesUseCase});

  final GetAgesUseCase getAgesUseCase;

  var isLoading = true.obs;
  var errorMessage = RxnString();
  var ages = <dynamic>[].obs;

  Future<void> displayAges() async {
    isLoading.value = true;
    errorMessage.value = null;
    var returnedData = await getAgesUseCase.call();
    returnedData.fold(
      (message) {
        errorMessage.value = message;
        ages.clear();
      },
      (data) {
        ages.value = data;
      },
    );
    isLoading.value = false;
  }
}
