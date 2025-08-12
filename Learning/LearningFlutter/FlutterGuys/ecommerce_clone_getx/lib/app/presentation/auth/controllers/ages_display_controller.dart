import 'package:ecommerce_clone_getx/app/domain/auth/usecases/get_ages_usecase.dart';
import 'package:get/get.dart';

enum AgesDisplayState { initial, loading, success, error }

class AgesDisplayController extends GetxController {
  AgesDisplayController({required this.getAgesUseCase});

  final GetAgesUseCase getAgesUseCase;

  var state = AgesDisplayState.initial.obs;
  var errorMessage = RxnString();
  var ages = <dynamic>[].obs;

  Future<void> displayAges() async {
    state.value = AgesDisplayState.loading;
    errorMessage.value = null;
    var returnedData = await getAgesUseCase.call();
    returnedData.fold(
      (message) {
        state.value = AgesDisplayState.error;
        errorMessage.value = message;
        ages.clear();
      },
      (data) {
        state.value = AgesDisplayState.success;
        ages.value = data;
      },
    );
  }
}
