import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/domain/auth/usecases/is_logged_in_usecase.dart';
import 'package:netflix/presentation/splash/bloc/splash_state.dart';
import 'package:netflix/service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashDisplayState());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    final isLoggedIn = await sl<IsLoggedInUsecase>().call();
    if (isLoggedIn) {
      emit(SplashAuthenticatedState());
    } else {
      emit(SplashUnAuthenticatedState());
    }
  }
}
