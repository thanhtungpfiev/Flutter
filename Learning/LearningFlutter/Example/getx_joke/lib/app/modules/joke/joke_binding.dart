import 'package:get/get.dart';
import 'package:getx_joke/app/data/joke/joke_service_interface.dart';

import 'joke_controller.dart';

class JokeBinding extends Bindings {
  @override
  void dependencies() {
    JokeServiceInterface.createInstance();
    Get.lazyPut<JokeController>(
      () => JokeController(jokeServiceInterface: Get.find<JokeServiceInterface>()),
    );
  }
}
