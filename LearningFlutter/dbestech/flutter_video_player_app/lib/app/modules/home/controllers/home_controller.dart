import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final infos = [].obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  _initData() async {
    await DefaultAssetBundle.of(Get.context!)
        .loadString('json/info.json')
        .then((value) {
      infos.value = json.decode(value);
    });
  }
}
