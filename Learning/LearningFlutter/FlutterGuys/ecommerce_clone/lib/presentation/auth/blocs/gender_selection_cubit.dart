import 'package:ecommerce_clone/common/enums/gender.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderSelectionCubit extends Cubit<Gender> {
  GenderSelectionCubit() : super(Gender.men);

  Gender selectedGender = Gender.men;

  void selectGender(Gender gender) {
    selectedGender = gender;
    emit(gender);
  }

  void selectMale() {
    emit(Gender.men);
  }

  void selectFemale() {
    emit(Gender.women);
  }
}
