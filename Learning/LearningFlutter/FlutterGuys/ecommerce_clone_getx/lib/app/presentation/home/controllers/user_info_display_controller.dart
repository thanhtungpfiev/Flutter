import 'package:ecommerce_clone_getx/app/core/utils/app_logger.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/entities/user_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/get_user_usecase.dart';
import 'package:get/get.dart';

enum UserInfoDisplayState { initial, loading, success, error }

class UserInfoDisplayController extends GetxController {
  UserInfoDisplayController({required this.getUserUseCase});

  final GetUserUseCase getUserUseCase;

  var state = UserInfoDisplayState.initial.obs;
  Rxn<UserEntity> user = Rxn<UserEntity>();

  @override
  void onInit() {
    super.onInit();
    displayUserInfo();
  }

  Future<void> displayUserInfo() async {
    try {
      state.value = UserInfoDisplayState.loading;
      await Future.delayed(const Duration(milliseconds: 500));
      var returnedData = await getUserUseCase.call();
      returnedData.fold(
        (error) {
          AppLogger.e('Failed to load user info', error);
          state.value = UserInfoDisplayState.error;
          user.value = null;
        },
        (data) {
          AppLogger.i('User info loaded successfully');
          state.value = UserInfoDisplayState.success;
          user.value = data;
        },
      );
    } catch (e) {
      AppLogger.e('Exception while loading user info', e);
      state.value = UserInfoDisplayState.error;
      user.value = null;
    }
  }

  void retryLoadUserInfo() {
    displayUserInfo();
  }
}
