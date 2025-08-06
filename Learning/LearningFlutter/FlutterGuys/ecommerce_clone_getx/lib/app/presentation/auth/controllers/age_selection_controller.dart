import 'package:get/get.dart';

class AgeSelectionController extends GetxController {
  var selectedAge = ''.obs;

  void selectAge(String age) {
    selectedAge.value = age;
  }
}
