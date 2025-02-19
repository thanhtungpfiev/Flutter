import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_joke/app/data/joke/joke_model.dart';
import 'package:getx_joke/app/data/joke/joke_service_interface.dart';

class JokeController extends GetxController {
  JokeServiceInterface jokeServiceInterface;

  JokeController({required this.jokeServiceInterface});

  var joke = '';
  var isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchJoke();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchJoke() async {
    isLoading = true;
    update();
    JokeModel jokeModel = await jokeServiceInterface.fetchJoke();
    if (jokeModel.joke != null) {
      joke = jokeModel.joke!;
    } else {
      Get.snackbar(
        'Oops',
        jokeModel.error!,
        colorText: Colors.white,
        backgroundColor: Colors.blue.shade800,
        icon: const Icon(Icons.add_alert),
      );
    }
    isLoading = false;
    update();
  }
}
