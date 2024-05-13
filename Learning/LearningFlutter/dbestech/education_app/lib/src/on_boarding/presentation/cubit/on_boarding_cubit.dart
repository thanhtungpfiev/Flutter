import 'package:bloc/bloc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer_usecase.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit(
    this._cacheFirstTimerUseCase,
    this._checkIfUserIsFirstTimerUseCase,
  ) : super(const OnBoardingInitialState());

  final CacheFirstTimerUseCase _cacheFirstTimerUseCase;
  final CheckIfUserIsFirstTimerUseCase _checkIfUserIsFirstTimerUseCase;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimerState());
    final result = await _cacheFirstTimerUseCase.call();
    result.fold(
      (failure) => emit(OnBoardingErrorState(message: failure.message)),
      (_) => emit(const UserCachedState()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimerState());
    final result = await _checkIfUserIsFirstTimerUseCase.call();
    result.fold(
      (failure) => emit(const OnBoardingStatusState(isFirstTimer: true)),
      (isFirstTimer) => emit(OnBoardingStatusState(isFirstTimer: isFirstTimer)),
    );
  }
}
