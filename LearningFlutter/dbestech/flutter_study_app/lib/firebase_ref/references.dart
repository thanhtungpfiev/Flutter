import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;
final questionPaperRF = fireStore.collection('questionPapers');

DocumentReference questionsRF(
        {required String questionPaperId, required String questionsId}) =>
    questionPaperRF
        .doc(questionPaperId)
        .collection("questions")
        .doc(questionsId);
