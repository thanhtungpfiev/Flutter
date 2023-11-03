import 'package:get/get.dart';

import '../controllers/video_info_controller.dart';

class VideoInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoInfoController>(
      () => VideoInfoController(),
    );
  }
}
