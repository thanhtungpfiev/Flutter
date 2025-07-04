import 'package:dartz/dartz.dart';
import 'package:ecommerce_clone/common/bloc/button/basic_reactive_button_state.dart';
import 'package:ecommerce_clone/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasicReactiveButtonCubit extends Cubit<BasicReactiveButtonState> {
  BasicReactiveButtonCubit() : super(BasicReactiveButtonInitialState());

  Future<void> execute({dynamic params, required UseCase usecase}) async {
    emit(BasicReactiveButtonLoadingState());

    try {
      Either result = await usecase.call(params: params);
      result.fold(
        (error) => emit(BasicReactiveButtonErrorState(errorMessage: error)),
        (data) => emit(BasicReactiveButtonSuccessState()),
      );
    } catch (e) {
      emit(BasicReactiveButtonErrorState(errorMessage: e.toString()));
    }
  }
}
