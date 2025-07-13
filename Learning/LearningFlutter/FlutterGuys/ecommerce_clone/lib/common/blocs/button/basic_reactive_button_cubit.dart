import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/common/blocs/button/basic_reactive_button_state.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicReactiveButtonCubit extends Cubit<BasicReactiveButtonState> {
  BasicReactiveButtonCubit() : super(BasicReactiveButtonInitialState());

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    emit(BasicReactiveButtonLoadingState());

    try {
      Either result = await usecase.call(params: params);
      result.fold(
        (error) => emit(BasicReactiveButtonLoadErrorState(errorMessage: error)),
        (data) => emit(BasicReactiveButtonLoadSuccessState()),
      );
    } catch (e) {
      emit(BasicReactiveButtonLoadErrorState(errorMessage: e.toString()));
    }
  }
}
