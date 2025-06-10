import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/auth/get_user_usecase.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  final GetUserUseCase getUserUseCase;

  ProfileInfoCubit(this.getUserUseCase) : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await getUserUseCase.call();

    user.fold(
      (l) {
        emit(ProfileInfoFailure());
      },
      (userEntity) {
        emit(ProfileInfoLoaded(userEntity: userEntity));
      },
    );
  }
}
