import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone_getx/app/core/usecase/usecase.dart';
import 'package:get/get.dart';

class BasicReactiveButtonController extends GetxController {
  var isLoading = false.obs;
  String? errorMessage;

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    isLoading.value = true;
    errorMessage = null;
    try {
      Either result = await usecase.call(params: params);
      result.fold(
        (error) {
          errorMessage = error;
        },
        (data) {
          errorMessage = null;
        },
      );
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
