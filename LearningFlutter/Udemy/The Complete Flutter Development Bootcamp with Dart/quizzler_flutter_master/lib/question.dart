// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Question {
  final String questionText;
  final bool questionAnswer;

  Question({
    required this.questionText,
    required this.questionAnswer,
  });

  Question copyWith({
    String? questionText,
    bool? questionAnswer,
  }) {
    return Question(
      questionText: questionText ?? this.questionText,
      questionAnswer: questionAnswer ?? this.questionAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionText': questionText,
      'questionAnswer': questionAnswer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionText: map['questionText'] as String,
      questionAnswer: map['questionAnswer'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Question(questionText: $questionText, questionAnswer: $questionAnswer)';

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.questionText == questionText &&
        other.questionAnswer == questionAnswer;
  }

  @override
  int get hashCode => questionText.hashCode ^ questionAnswer.hashCode;
}
