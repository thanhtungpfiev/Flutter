import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shared_preferences_helper.dart';

class ThemeHelper extends GetxController {
  static final ThemeHelper _singleton = ThemeHelper._internal();

  factory ThemeHelper() {
    return _singleton;
  }

  ThemeHelper._internal();

  static const _isDarkModeKey = 'isDarkMode';
  final isDarkMode = false.obs;

  bool getDarkModeValue() {
    isDarkMode.value =
        SharedPreferencesHelper.instance.getBool(_isDarkModeKey) ?? false;
    return isDarkMode.value;
  }

  void saveDarkModeValue(bool value) {
    SharedPreferencesHelper.instance.setBool(_isDarkModeKey, value);
  }

  ThemeMode getThemeMode() {
    return getDarkModeValue() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeThemeMode() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
    saveDarkModeValue(!Get.isDarkMode);
    isDarkMode.value = !Get.isDarkMode;
  }
}
