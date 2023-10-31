import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/utils/assets_helper.dart';

class DetailController extends GetxController {
  final imgs = [].obs;
  final isFav = false.obs;

  void readData() {
    AssetsHelper.loadAsset(Get.context!, "assets/json/img.json")
        .then((value) => imgs.value = json.decode(value));
  }

  @override
  void onInit() {
    readData();
    super.onInit();
  }

  void handleFav() {
    if (!isFav.value) {
      isFav.value = true;
      Get.snackbar('Love it', 'You just loved it');
    } else {
      Get.snackbar('Love it', 'You already loved it');
    }
  }
}
