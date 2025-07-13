abstract class BasicReactiveButtonState {}

class BasicReactiveButtonInitialState extends BasicReactiveButtonState {}

class BasicReactiveButtonLoadingState extends BasicReactiveButtonState {}

class BasicReactiveButtonLoadSuccessState extends BasicReactiveButtonState {}

class BasicReactiveButtonLoadErrorState extends BasicReactiveButtonState {
  final String errorMessage;

  BasicReactiveButtonLoadErrorState({required this.errorMessage});
}
