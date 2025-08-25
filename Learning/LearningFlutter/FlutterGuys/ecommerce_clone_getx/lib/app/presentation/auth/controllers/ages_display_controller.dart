import 'package:ecommerce_clone_getx/app/domain/auth/usecases/get_ages_usecase.dart';
import 'package:get/get.dart';

enum AgesDisplayState { initial, loading, success, error }

class AgesDisplayController extends GetxController {
  AgesDisplayController({required this.getAgesUseCase});

  final GetAgesUseCase getAgesUseCase;

  final state = AgesDisplayState.initial.obs;
  final errorMessage = ''.obs;
  final ages = <dynamic>[].obs;

  Future<void> displayAges() async {
    state.value = AgesDisplayState.loading;
    errorMessage.value = '';
    var returnedData = await getAgesUseCase.call();
    returnedData.fold(
      (error) {
        state.value = AgesDisplayState.error;
        errorMessage.value = error;
        ages.clear();
      },
      (data) {
        state.value = AgesDisplayState.success;
        errorMessage.value = '';
        ages.value = data;
      },
    );
  }
}
