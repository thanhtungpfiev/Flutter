import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;
final questionPaperRF = fireStore.collection("questionPapers");
final userRF = fireStore.collection("users");

DocumentReference questionsRF(
        {required String questionPaperId, required String questionsId}) =>
    questionPaperRF
        .doc(questionPaperId)
        .collection("questions")
        .doc(questionsId);

Reference get firebaseStorage => FirebaseStorage.instance.ref();
