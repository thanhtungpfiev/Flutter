import 'dart:io';

import 'package:dio/dio.dart';
import 'package:getx_joke/app/data/joke/joke_model.dart';

import 'joke_service_interface.dart';

class JokeServiceDio implements JokeServiceInterface {
  final String url = 'https://v2.jokeapi.dev/joke/Programming?format=json&type=single';
  final Dio _dio = Dio();


  @override
  Future<JokeModel> fetchJoke() async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == HttpStatus.ok) {
        return JokeModel(joke: response.data['joke']);
      } else {
        return JokeModel(error: 'Failed to load joke');
      }
    } on DioException catch(e) {
      return JokeModel(error: 'Dio Error: ${e.message}');
    }
    catch (e) {
      return JokeModel(error: 'Error: $e');
    }
  }

}
