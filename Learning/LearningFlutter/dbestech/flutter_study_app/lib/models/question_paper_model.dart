import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  late String _id;
  late String _title;
  late String _imageUrl;
  late String _description;
  late int _timeSeconds;
  late int _questionCount;
  late List<Question> _questions;

  String get id => _id;

  String get title => _title;

  // ignore: unnecessary_getters_setters
  String get imageUrl => _imageUrl;

  String get description => _description;

  int get timeSeconds => _timeSeconds;

  int get questionCount => _questionCount;

  // ignore: unnecessary_getters_setters
  List<Question> get questions => _questions;

  set imageUrl(String imageUrl) => _imageUrl = imageUrl;

  set questions(List<Question> questions) => _questions = questions;

  QuestionPaperModel({
    required String id,
    required String title,
    required String imageUrl,
    required String description,
    required int timeSeconds,
    required List<Question> questions,
    required int questionCount,
  }) {
    _id = id;
    _title = title;
    _imageUrl = imageUrl;
    _description = description;
    _timeSeconds = timeSeconds;
    _questionCount = questionCount;
    _questions = questions;
  }

  QuestionPaperModel copyWith({
    required String id,
    required String title,
    required String imageUrl,
    required String description,
    required int timeSeconds,
    required int questionCount,
    required List<Question> questions,
  }) =>
      QuestionPaperModel(
        id: id,
        title: title,
        imageUrl: imageUrl,
        description: description,
        timeSeconds: timeSeconds,
        questionCount: questionCount,
        questions: questions,
      );

  QuestionPaperModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _imageUrl = json['image_url'];
    _description = json['Description'];
    _timeSeconds = json['time_seconds'];
    _questionCount = 0;
    if (json['questions'] != null) {
      _questions = [];
      json['questions'].forEach((v) {
        _questions.add(Question.fromJson(v));
      });
    }
  }

  QuestionPaperModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.id;
    _title = snapshot['title'];
    _imageUrl = snapshot['image_url'];
    _description = snapshot['Description'];
    _timeSeconds = snapshot['time_seconds'];
    _questionCount = snapshot['question_count'];
    _questions = [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image_url'] = _imageUrl;
    map['Description'] = _description;
    map['time_seconds'] = _timeSeconds;
    map['question_count'] = _questionCount;
    map['questions'] = _questions.map((v) => v.toJson()).toList();
    return map;
  }

  String timeInMinutes() => "${(timeSeconds / 60).ceil()} mins";
}

/// id : "ppr004q001"
/// question : "A relationship in which one animal hunts, kills and eats another"
/// answers : [{"identifier":"A","Answer":"Symbiosis"},{"identifier":"B","Answer":"Mutualism"},{"identifier":"C","Answer":"Parasitism"},{"identifier":"D","Answer":"Predation"}]
/// correct_answer : "D"

class Question {
  late String _id;
  late String _question;
  late List<Answer> _answers;
  late String _correctAnswer;
  String? _selectedAnswer;

  String get id => _id;

  String get question => _question;

  // ignore: unnecessary_getters_setters
  List<Answer> get answers => _answers;

  String get correctAnswer => _correctAnswer;

  // ignore: unnecessary_getters_setters
  String? get selectedAnswer => _selectedAnswer;

  set answers(List<Answer> answers) => _answers = answers;

  set selectedAnswer(String? selectedAnswer) =>
      _selectedAnswer = selectedAnswer;

  Question({
    required String id,
    required String question,
    required List<Answer> answers,
    required String correctAnswer,
  }) {
    _id = id;
    _question = question;
    _answers = answers;
    _correctAnswer = correctAnswer;
  }

  Question copyWith({
    required String id,
    required String question,
    required List<Answer> answers,
    required String correctAnswer,
  }) =>
      Question(
        id: id,
        question: question,
        answers: answers,
        correctAnswer: correctAnswer,
      );

  Question.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    if (json['answers'] != null) {
      _answers = [];
      json['answers'].forEach((v) {
        _answers.add(Answer.fromJson(v));
      });
    }
    _correctAnswer = json['correct_answer'];
  }

  Question.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.id;
    _question = snapshot['question'];
    _answers = [];
    _correctAnswer = snapshot['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['question'] = _question;
    map['answers'] = _answers.map((v) => v.toJson()).toList();
    map['correct_answer'] = _correctAnswer;
    return map;
  }
}

/// identifier : "A"
/// Answer : "Symbiosis"

class Answer {
  late String _identifier;
  late String _answer;

  String get identifier => _identifier;

  String get answer => _answer;

  Answer({
    required String identifier,
    required String answer,
  }) {
    _identifier = identifier;
    _answer = answer;
  }

  Answer copyWith({
    required String identifier,
    required String answer,
  }) =>
      Answer(
        identifier: identifier,
        answer: answer,
      );

  Answer.fromJson(dynamic json) {
    _identifier = json['identifier'];
    _answer = json['Answer'];
  }

  Answer.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    _identifier = snapshot['identifier'];
    _answer = snapshot['Answer'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identifier'] = _identifier;
    map['Answer'] = _answer;
    return map;
  }
}
