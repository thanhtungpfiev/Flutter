import 'package:ecommerce_clone/domain/auth/usecases/get_ages_usecase.dart';
import 'package:ecommerce_clone/presentation/auth/bloc/ages_display_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgesDisplayCubit extends Cubit<AgesDisplayState> {
  AgesDisplayCubit({required this.getAgesUseCase})
    : super(AgesDisplayLoadingState());

  final GetAgesUseCase getAgesUseCase;

  void displayAges() async {
    var returnedData = await getAgesUseCase.call();

    returnedData.fold(
      (message) {
        emit(AgesDisplayLoadErrorState(errorMessage: message));
      },
      (data) {
        emit(AgesDisplaySuccessState(ages: data));
      },
    );
  }
}
