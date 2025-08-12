import 'package:get/get.dart';

class ProductColorSelectionController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void itemSelection(int index) {
    selectedIndex.value = index;
  }
}
