import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/utils/assets_helper.dart';

class ContentController extends GetxController {
  final recents = [].obs;
  final details = [].obs;

  void readData() {
    AssetsHelper.loadAsset(Get.context!, "assets/json/recent.json")
        .then((value) => recents.value = json.decode(value));
    AssetsHelper.loadAsset(Get.context!, "assets/json/detail.json")
        .then((value) => details.value = json.decode(value));
  }

  @override
  void onInit() {
    readData();
    super.onInit();
  }
}
