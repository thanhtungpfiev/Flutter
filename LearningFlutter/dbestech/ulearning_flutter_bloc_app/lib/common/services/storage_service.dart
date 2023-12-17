import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../entities/user.dart';
import '../values/constants.dart';

class StorageService {
  late final SharedPreferences _prefs;
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  bool getDeviceFirstOpen() {
    return _prefs.getBool(AppConstants.storageDeviceOpenFirstTime) ?? false;
  }

  bool getIsLoggedIn() {
    return _prefs.getString(AppConstants.storageUserTokenKey) == null
        ? false
        : true;
  }

  UserItem? getUserProfile() {
    var profileOffline =
        _prefs.getString(AppConstants.storageUserProfileKey) ?? '';
    if (profileOffline.isNotEmpty) {
      return UserItem.fromJson(json.decode(profileOffline));
    }
    return null;
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  String getUserToken() {
    return _prefs.getString(AppConstants.storageUserTokenKey) ?? '';
  }
}
