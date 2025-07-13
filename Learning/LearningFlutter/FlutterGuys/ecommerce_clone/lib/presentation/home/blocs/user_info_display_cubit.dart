import 'package:ecommerce_clone/domain/auth/usecases/get_user_usecase.dart';
import 'package:ecommerce_clone/presentation/home/blocs/user_info_display_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  UserInfoDisplayCubit({required this.getUserUseCase})
    : super(UserInfoDisplayLoadingState());

  final GetUserUseCase getUserUseCase;

  void displayUserInfo() async {
    try {
      var returnedData = await getUserUseCase.call();
      returnedData.fold(
        (error) {
          emit(UserInfoDisplayLoadErrorState());
        },
        (data) {
          emit(UserInfoDisplayLoadSuccessState(user: data));
        },
      );
    } catch (e) {
      emit(UserInfoDisplayLoadErrorState());
    }
  }
}
