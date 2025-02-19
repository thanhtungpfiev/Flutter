import 'package:get/get.dart';
import 'package:getx_joke/app/data/joke/joke_model.dart';

import 'joke_service_dio.dart';

abstract interface class JokeServiceInterface {
  Future<JokeModel> fetchJoke();

  static void createInstance() {
    Get.put<JokeServiceInterface>(JokeServiceDio(), permanent: true);
  }
}
