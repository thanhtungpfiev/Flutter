// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc/bloc.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer_usecase.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit(this._cacheFirstTimerUseCase, this._checkIfUserIsFirstTimerUseCase)
      : super(const OnBoardingInitial());

  final CacheFirstTimerUseCase _cacheFirstTimerUseCase;
  final CheckIfUserIsFirstTimerUseCase _checkIfUserIsFirstTimerUseCase;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimerUseCase.call();
    result.fold(
      (failure) => emit(OnBoardingError(message: failure.message)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserIsFirstTimer());
    final result = await _checkIfUserIsFirstTimerUseCase.call();
    result.fold(
      (failure) => emit(const OnBoardingStatus(isFirstTimer: true)),
      (isFirstTimer) => emit(OnBoardingStatus(isFirstTimer: isFirstTimer)),
    );
  }
}
