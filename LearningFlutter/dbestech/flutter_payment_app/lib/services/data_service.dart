import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/data_model.dart';

class DataService {
  final String _baseUrl = 'http://192.168.88.122/Test/public/api';
  Future<List<dynamic>> getUsers() async {
    var info = await rootBundle.loadString('json/data.json');
    var list = json.decode(info);
    return list;
  }

  Future<List<DataModel>> getBillInfos() async {
    var apiUrl = 'billinfo';
    http.Response response = await http.get(Uri.parse('$_baseUrl/$apiUrl'));
    try {
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> list = await json.decode(response.body);
        return list.map((e) => DataModel.fromMap(e)).toList();
      } else {
        print('Something went wrong');
        return <DataModel>[];
      }
    } catch (e) {
      print(e);
      print('Api request failed');
      return <DataModel>[];
    }
  }
}
