part of 'on_boarding_cubit.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();
  @override
  List<Object> get props => [];
}

class OnBoardingInitialState extends OnBoardingState {
  const OnBoardingInitialState();
}

class CachingFirstTimerState extends OnBoardingState {
  const CachingFirstTimerState();
}

class CheckingIfUserIsFirstTimerState extends OnBoardingState {
  const CheckingIfUserIsFirstTimerState();
}

class UserCachedState extends OnBoardingState {
  const UserCachedState();
}

class OnBoardingStatusState extends OnBoardingState {
  const OnBoardingStatusState({required this.isFirstTimer});
  final bool isFirstTimer;
  @override
  List<Object> get props => [isFirstTimer];
}

class OnBoardingErrorState extends OnBoardingState {
  const OnBoardingErrorState({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
