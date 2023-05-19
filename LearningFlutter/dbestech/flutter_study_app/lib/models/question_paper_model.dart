/// id : "ppr004"
/// title : "Biology"
/// image_url : ""
/// Description : "Basic Biology Multiple Choice Questions (MCQ) to practice basic Biology quiz answers"
/// time_seconds : 900
/// questions : [{"id":"ppr004q001","question":"A relationship in which one animal hunts, kills and eats another","answers":[{"identifier":"A","Answer":"Symbiosis"},{"identifier":"B","Answer":"Mutualism"},{"identifier":"C","Answer":"Parasitism"},{"identifier":"D","Answer":"Predation"}],"correct_answer":"D"},{"id":"ppr004q002","question":"The animal that is hunted and killed for food.","answers":[{"identifier":"A","Answer":"Decomposer"},{"identifier":"B","Answer":"Predator"},{"identifier":"C","Answer":"Scavenger"},{"identifier":"D","Answer":"Prey"}],"correct_answer":"D"},{"id":"ppr004q003","question":"A close relationship between two different species of organisms living together.","answers":[{"identifier":"A","Answer":"Mutualism"},{"identifier":"B","Answer":"Symbiosis"},{"identifier":"C","Answer":"Competition"},{"identifier":"D","Answer":"Commensialism"}],"correct_answer":"B"},{"id":"ppr004q004","question":"A symbiotic relationship in which both species benefit.","answers":[{"identifier":"A","Answer":"Mutualism"},{"identifier":"B","Answer":"Commensialism"},{"identifier":"C","Answer":"Parasitism"},{"identifier":"D","Answer":"Predation"}],"correct_answer":"A"},{"id":"ppr004q005","question":"Which organelle is found in most plants, some bacteria and some protists?","answers":[{"identifier":"A","Answer":"ribosomes"},{"identifier":"B","Answer":"mitochondria"},{"identifier":"C","Answer":"endoplasmic reticulum"},{"identifier":"D","Answer":"chloroplasts"}],"correct_answer":"D"}]

class QuestionPaperModel {
  QuestionPaperModel({
    required String id,
    required String title,
    required String imageUrl,
    required String description,
    required num timeSeconds,
    required List<Questions> questions,
  }) {
    _id = id;
    _title = title;
    _imageUrl = imageUrl;
    _description = description;
    _timeSeconds = timeSeconds;
    _questions = questions;
  }

  QuestionPaperModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _imageUrl = json['image_url'];
    _description = json['Description'];
    _timeSeconds = json['time_seconds'];
    if (json['questions'] != null) {
      _questions = [];
      json['questions'].forEach((v) {
        _questions.add(Questions.fromJson(v));
      });
    }
  }

  late String _id;
  late String _title;
  late String _imageUrl;
  late String _description;
  late num _timeSeconds;
  late List<Questions> _questions;

  QuestionPaperModel copyWith({
    required String id,
    required String title,
    required String imageUrl,
    required String description,
    required num timeSeconds,
    required List<Questions> questions,
  }) =>
      QuestionPaperModel(
        id: id,
        title: title,
        imageUrl: imageUrl,
        description: description,
        timeSeconds: timeSeconds,
        questions: questions,
      );

  String get id => _id;

  String get title => _title;

  String get imageUrl => _imageUrl;

  String get description => _description;

  num get timeSeconds => _timeSeconds;

  List<Questions> get questions => _questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image_url'] = _imageUrl;
    map['Description'] = _description;
    map['time_seconds'] = _timeSeconds;
    map['questions'] = _questions.map((v) => v.toJson()).toList();
    return map;
  }
}

/// id : "ppr004q001"
/// question : "A relationship in which one animal hunts, kills and eats another"
/// answers : [{"identifier":"A","Answer":"Symbiosis"},{"identifier":"B","Answer":"Mutualism"},{"identifier":"C","Answer":"Parasitism"},{"identifier":"D","Answer":"Predation"}]
/// correct_answer : "D"

class Questions {
  Questions({
    required String id,
    required String question,
    required List<Answers> answers,
    required String correctAnswer,
  }) {
    _id = id;
    _question = question;
    _answers = answers;
    _correctAnswer = correctAnswer;
  }

  Questions.fromJson(dynamic json) {
    _id = json['id'];
    _question = json['question'];
    if (json['answers'] != null) {
      _answers = [];
      json['answers'].forEach((v) {
        _answers.add(Answers.fromJson(v));
      });
    }
    _correctAnswer = json['correct_answer'];
  }

  late String _id;
  late String _question;
  late List<Answers> _answers;
  late String _correctAnswer;

  Questions copyWith({
    required String id,
    required String question,
    required List<Answers> answers,
    required String correctAnswer,
  }) =>
      Questions(
        id: id,
        question: question,
        answers: answers,
        correctAnswer: correctAnswer,
      );

  String get id => _id;

  String get question => _question;

  List<Answers> get answers => _answers;

  String get correctAnswer => _correctAnswer;

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

class Answers {
  Answers({
    required String identifier,
    required String answer,
  }) {
    _identifier = identifier;
    _answer = answer;
  }

  Answers.fromJson(dynamic json) {
    _identifier = json['identifier'];
    _answer = json['Answer'];
  }

  late String _identifier;
  late String _answer;

  Answers copyWith({
    required String identifier,
    required String answer,
  }) =>
      Answers(
        identifier: identifier,
        answer: answer,
      );

  String get identifier => _identifier;

  String get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identifier'] = _identifier;
    map['Answer'] = _answer;
    return map;
  }
}
