abstract class BasicReactiveButtonState {}

class BasicReactiveButtonInitialState extends BasicReactiveButtonState {}

class BasicReactiveButtonLoadingState extends BasicReactiveButtonState {}

class BasicReactiveButtonSuccessState extends BasicReactiveButtonState {}

class BasicReactiveButtonErrorState extends BasicReactiveButtonState {
  final String errorMessage;

  BasicReactiveButtonErrorState({required this.errorMessage});
}
