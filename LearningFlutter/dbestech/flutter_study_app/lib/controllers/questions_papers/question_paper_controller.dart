import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';
import '../../models/question_paper_model.dart';
import '../../routes/app_routes.dart';
import '../../services/firebase_storage_service.dart';
import '../../util/app_logger.dart';
import '../auth_controller.dart';

class QuestionPaperController extends GetxController {
  final allPapers = <QuestionPaperModel>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    try {
      QuerySnapshot data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);
      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl ?? "";
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.logger.e(e);
    }
  }

  void navigateToQuestions(
      {required QuestionPaperModel paper, bool tryAgain = false}) {
    AuthController authController = Get.find();
    if (authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(AppRoutes.questionsRoute,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(AppRoutes.questionsRoute, arguments: paper);
      }
    } else {
      authController.showLoginAlertDialogue();
    }
  }
}
