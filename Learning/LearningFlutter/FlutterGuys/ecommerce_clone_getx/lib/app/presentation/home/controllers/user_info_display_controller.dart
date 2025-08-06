import 'package:ecommerce_clone_getx/app/core/utils/app_logger.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/entities/user_entity.dart';
import 'package:ecommerce_clone_getx/app/domain/auth/usecases/get_user_usecase.dart';
import 'package:get/get.dart';

class UserInfoDisplayController extends GetxController {
  UserInfoDisplayController({required this.getUserUseCase});

  final GetUserUseCase getUserUseCase;

  var isLoading = true.obs;
  Rxn<UserEntity> user = Rxn<UserEntity>();

  @override
  void onInit() {
    super.onInit();
    displayUserInfo();
  }

  Future<void> displayUserInfo() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 500));
      var returnedData = await getUserUseCase.call();
      returnedData.fold(
        (error) {
          AppLogger.e('Failed to load user info', error);
          user.value = null;
        },
        (data) {
          AppLogger.i('User info loaded successfully');
          user.value = data;
        },
      );
    } catch (e) {
      AppLogger.e('Exception while loading user info', e);
      user.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  void retryLoadUserInfo() {
    displayUserInfo();
  }
}
