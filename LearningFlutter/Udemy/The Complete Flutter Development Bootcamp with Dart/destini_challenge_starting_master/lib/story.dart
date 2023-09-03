// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Story {
  final String storyTitle;
  final String choice1;
  final String choice2;
  Story({
    required this.storyTitle,
    required this.choice1,
    required this.choice2,
  });

  Story copyWith({
    String? storyTitle,
    String? choice1,
    String? choice,
  }) {
    return Story(
      storyTitle: storyTitle ?? this.storyTitle,
      choice1: choice1 ?? this.choice1,
      choice2: choice ?? this.choice2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storyTitle': storyTitle,
      'choice1': choice1,
      'choice': choice2,
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      storyTitle: map['storyTitle'] as String,
      choice1: map['choice1'] as String,
      choice2: map['choice'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Story.fromJson(String source) =>
      Story.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Story(storyTitle: $storyTitle, choice1: $choice1, choice: $choice2)';

  @override
  bool operator ==(covariant Story other) {
    if (identical(this, other)) return true;

    return other.storyTitle == storyTitle &&
        other.choice1 == choice1 &&
        other.choice2 == choice2;
  }

  @override
  int get hashCode => storyTitle.hashCode ^ choice1.hashCode ^ choice2.hashCode;
}
