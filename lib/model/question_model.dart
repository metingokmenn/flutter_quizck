import 'dart:convert';

import 'package:hive/hive.dart';
part 'question_model.g.dart';

@HiveType(typeId: 2)
class Question extends HiveObject {
  @HiveField(0)
  String question;
  @HiveField(1)
  List<String> options;
  @HiveField(2)
  int correctAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory Question.fromJson(String str) => Question.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        question: json["question"],
        options: List<String>.from(json["options"].map((x) => x)),
        correctAnswerIndex: json["correctAnswerIndex"],
      );

  Map<String, dynamic> toMap() => {
        "question": question,
        "options": List<dynamic>.from(options.map((x) => x)),
        "correctAnswerIndex": correctAnswerIndex,
      };

  @override
  String toString() {
    return '"question":"$question","options":$options,"correctAnswerIndex":$correctAnswerIndex';
  }
}
