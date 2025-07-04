import 'package:ecommerce_clone/domain/auth/usecases/is_logged_in_usecase.dart';
import 'package:ecommerce_clone/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.isLoggedInUseCase}) : super(DisplaySplash());

  final IsLoggedInUseCase isLoggedInUseCase;

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    var isLoggedIn = await isLoggedInUseCase.call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
