import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';
import '../auth_controller.dart';
import 'questions_controller.dart';

extension QuestionsControllerExtension on QuestionsController {
  int get correctAnsweredQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestionString {
    return "$correctAnsweredQuestionCount out of ${allQuestions.length} are correct";
  }

  String get points {
    var points = (correctAnsweredQuestionCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - remainSeconds) /
        questionPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResults() async {
    var batch = fireStore.batch();
    User? user = Get.find<AuthController>().getUser();
    if (user == null) return;
    batch.set(
        userRF
            .doc(user.email)
            .collection('myrecent_tests')
            .doc(questionPaperModel.id),
        {
          "points": points,
          "correct_answer":
              "$correctAnsweredQuestionCount/${allQuestions.length}",
          "question_id": questionPaperModel.id,
          "time": questionPaperModel.timeSeconds - remainSeconds
        });
    batch.commit();
    navigateToHome();
  }
}
