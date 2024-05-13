import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelper {
  final Uri uri;

  NetworkHelper({required this.uri});

  Future getData() async {
    var dataJson;
    Response response = await get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      dataJson = jsonDecode(data);
    } else {
      print(response.statusCode);
    }
    return dataJson;
  }
}
