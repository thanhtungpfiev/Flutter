import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoInfoController extends GetxController {
  final videoInfos = [].obs;
  final playArea = false.obs;
  late VideoPlayerController videoPlayerController;
  final controllerInitialized = false.obs;
  final isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController.pause();
    videoPlayerController.dispose();
  }

  _initData() async {
    await DefaultAssetBundle.of(Get.context!)
        .loadString('json/videoinfo.json')
        .then((value) {
      videoInfos.value = json.decode(value);
    });
  }

  void onTapVideo(int index) {
    playArea.value = true;
    controllerInitialized.value = false;
    isPlaying.value = false;

    videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(videoInfos[index]['videoUrl']))
      ..initialize().then((_) {
        controllerInitialized.value = true;
        isPlaying.value = true;
        videoPlayerController.addListener(() {
          if (videoPlayerController.value.isCompleted) {
            isPlaying.value = false;
            videoPlayerController.initialize();
          }
        });
        videoPlayerController.play();
      });
  }

  void handlePlayPauseButton() {
    if (isPlaying.value == true) {
      isPlaying.value = false;
      videoPlayerController.pause();
    } else {
      isPlaying.value = true;
      videoPlayerController.play();
    }
  }
}
