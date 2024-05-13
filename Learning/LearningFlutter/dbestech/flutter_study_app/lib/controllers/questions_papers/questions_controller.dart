import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../firebase_ref/references.dart';
import '../../models/question_paper_model.dart';
import '../../routes/app_routes.dart';
import '../../util/app_logger.dart';
import 'loading_status.dart';
import 'question_paper_controller.dart';

class QuestionsController extends GetxController {
  late QuestionPaperModel questionPaperModel;
  final allQuestions = <Question>[];
  final loadingStatus = LoadingStatus.loading.obs;
  Rxn<Question> currentQuestion = Rxn<Question>();
  final questionIndex = 0.obs;
  int remainSeconds = 1;
  final time = '00.00'.obs;
  Timer? _timer;

  bool get isFirstQuestion => questionIndex.value <= 0;

  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;

  @override
  void onReady() {
    final questionPaper = Get.arguments as QuestionPaperModel;
    loadData(questionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection("questions")
              .get();
      final questions = questionQuery.docs
          .map((snapshot) => Question.fromSnapshot(snapshot))
          .toList();
      questionPaperModel.questions.assignAll(questions);
      for (Question question in questionPaperModel.questions) {
        final QuerySnapshot<Map<String, dynamic>> answerQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(question.id)
                .collection("answers")
                .get();
        final answers = answerQuery.docs
            .map((snapshot) => Answer.fromSnapshot(snapshot))
            .toList();
        question.answers = answers;
      }
      if (questionPaperModel.questions.isNotEmpty) {
        allQuestions.assignAll(questionPaperModel.questions);
        currentQuestion.value = questionPaperModel.questions[0];
        _startTimer(questionPaper.timeSeconds);
        loadingStatus.value = LoadingStatus.completed;
      } else {
        loadingStatus.value = LoadingStatus.error;
      }
    } catch (e) {
      AppLogger.logger.e(e.toString());
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list']);
  }

  void nextQuestion() {
    if (isLastQuestion) {
      return;
    }
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (isFirstQuestion) {
      return;
    }
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainSeconds--;
      }
    });
  }

  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return "$answered out of ${allQuestions.length} answered";
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (isGoBack) {
      Get.back();
    } else {
      Get.toNamed(AppRoutes.answerCheckRoute);
    }
  }

  void completed() {
    _timer!.cancel();
    Get.offAndToNamed(AppRoutes.resultRoute);
  }

  void tryAgain() {
    var questionPaperController = Get.find<QuestionPaperController>();
    questionPaperController.navigateToQuestions(
        paper: questionPaperModel, tryAgain: true);
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(AppRoutes.homeRoute, (route) => false);
  }
}
