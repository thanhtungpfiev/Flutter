import 'package:ecommerce_clone_getx/app/common/enums/gender.dart';
import 'package:get/get.dart';

class GenderSelectionController extends GetxController {
  var selectedGender = Gender.men.obs;

  void selectGender(Gender gender) {
    selectedGender.value = gender;
  }

  void selectMale() {
    selectedGender.value = Gender.men;
  }

  void selectFemale() {
    selectedGender.value = Gender.women;
  }
}
