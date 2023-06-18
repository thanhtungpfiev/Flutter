import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_study_app/firebase_ref/references.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:flutter_study_app/services/firebase_storage_service.dart';
import 'package:get/get.dart';

import '../../util/app_logger.dart';
import '../auth_controller.dart';

class QuestionPaperController extends GetxController {
  final allPapers = <QuestionPaperModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    getAllPapers();
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
      } else {}
    } else {
      authController.showLoginAlertDialogue();
    }
  }
}
