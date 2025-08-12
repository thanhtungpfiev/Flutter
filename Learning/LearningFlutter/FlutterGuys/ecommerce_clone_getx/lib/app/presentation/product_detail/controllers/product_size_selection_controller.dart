import 'package:get/get.dart';

class ProductSizeSelectionController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void itemSelection(int index) {
    selectedIndex.value = index;
  }
}
