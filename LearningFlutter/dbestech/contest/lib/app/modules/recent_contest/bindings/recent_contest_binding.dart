import 'package:get/get.dart';

import '../controllers/recent_contest_controller.dart';

class RecentContestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentContestController>(
      () => RecentContestController(),
    );
  }
}
