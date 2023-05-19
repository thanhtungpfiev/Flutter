import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_study_app/controllers/questions_papers/loading_status.dart';
import 'package:flutter_study_app/firebase_ref/references.dart';
import 'package:flutter_study_app/models/question_paper_model.dart';
import 'package:get/get.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    Map<String, dynamic> manifestMap = jsonDecode(manifestContent);

    // * load json file from assets
    final paperInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith('assets/DB/papers') && path.endsWith('.json'))
        .toList();
    List<QuestionPaperModel> questionPapers = [];
    for (var paper in paperInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(jsonDecode(stringPaperContent)));
    }

    // ? convert json to model object and upload to firebase database
    var batch = fireStore.batch();
    for (var paper in questionPapers) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "Description": paper.description,
        "time_seconds": paper.timeSeconds,
        "question_count": paper.questions.length
      });
      for (var questions in paper.questions) {
        final questionPath =
            questionsRF(questionPaperId: paper.id, questionsId: questions.id);
        batch.set(questionPath, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });
        for (var answers in questions.answers) {
          final answerPath =
              questionPath.collection("answers").doc(answers.identifier);
          batch.set(answerPath,
              {"identifier": answers.identifier, "Answer": answers.answer});
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
