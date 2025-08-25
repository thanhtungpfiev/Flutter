import 'package:get/get.dart';

class AgeSelectionController extends GetxController {
  final selectedAge = ''.obs;

  void selectAge(String age) {
    selectedAge.value = age;
  }
}
