import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:get/get.dart';

enum BasicReactiveButtonState { initial, loading, success, error }

class BasicReactiveButtonController extends GetxController {
  final state = BasicReactiveButtonState.initial.obs;
  final errorMessage = ''.obs;

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    state.value = BasicReactiveButtonState.loading;
    errorMessage.value = '';
    try {
      Either result = await usecase.call(params: params);
      result.fold(
        (error) {
          state.value = BasicReactiveButtonState.error;
          errorMessage.value = error;
        },
        (data) {
          state.value = BasicReactiveButtonState.success;
          errorMessage.value = '';
        },
      );
    } catch (e) {
      state.value = BasicReactiveButtonState.error;
      errorMessage.value = e.toString();
    }
  }
}
