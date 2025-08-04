import 'package:ecommerce_clone/core/utils/app_logger.dart';
import 'package:ecommerce_clone/domain/auth/usecases/get_user_usecase.dart';
import 'package:ecommerce_clone/presentation/home/blocs/user_info_display_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  UserInfoDisplayCubit({required this.getUserUseCase})
    : super(UserInfoDisplayLoadingState());

  final GetUserUseCase getUserUseCase;

  void displayUserInfo() async {
    try {
      emit(UserInfoDisplayLoadingState());

      // Add small delay to allow Firebase to initialize properly
      await Future.delayed(const Duration(milliseconds: 500));

      var returnedData = await getUserUseCase.call();
      returnedData.fold(
        (error) {
          AppLogger.e('Failed to load user info', error);
          emit(UserInfoDisplayLoadErrorState());
        },
        (data) {
          AppLogger.i('User info loaded successfully');
          emit(UserInfoDisplayLoadSuccessState(user: data));
        },
      );
    } catch (e) {
      AppLogger.e('Exception while loading user info', e);
      emit(UserInfoDisplayLoadErrorState());
    }
  }

  void retryLoadUserInfo() {
    displayUserInfo();
  }
}
