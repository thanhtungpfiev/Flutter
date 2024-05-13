import 'package:flutter/material.dart';

class AssetsHelper {
  AssetsHelper._();

  static Future<String> loadAsset(BuildContext context, String path) async {
    String result = await DefaultAssetBundle.of(context).loadString(path);
    return result;
  }
}
