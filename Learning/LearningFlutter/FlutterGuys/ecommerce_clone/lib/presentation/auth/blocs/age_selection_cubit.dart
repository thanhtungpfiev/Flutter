import 'package:ecommerce_clone/core/constants/ui_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgeSelectionCubit extends Cubit<String> {
  AgeSelectionCubit() : super(UIConstants.ageRange);

  String selectedAge = '';

  void selectAge(String age) {
    selectedAge = age;
    emit(selectedAge);
  }
}
