import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:get/get.dart';

enum BasicReactiveButtonState { initial, loading, success, error }

class BasicReactiveButtonController extends GetxController {
  var state = BasicReactiveButtonState.initial.obs;
  String? errorMessage;

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    state.value = BasicReactiveButtonState.loading;
    errorMessage = null;
    try {
      Either result = await usecase.call(params: params);
      result.fold(
        (error) {
          state.value = BasicReactiveButtonState.error;
          errorMessage = error;
        },
        (data) {
          state.value = BasicReactiveButtonState.success;
          errorMessage = null;
        },
      );
    } catch (e) {
      state.value = BasicReactiveButtonState.error;
      errorMessage = e.toString();
    }
  }
}
