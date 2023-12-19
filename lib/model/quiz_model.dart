import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:flutter_quizck/model/question_model.dart';

part 'quiz_model.g.dart';

@HiveType(typeId: 1)
class Quiz extends HiveObject {
  @HiveField(0)
  List<Question> questions;

  @HiveField(1)
  String quizName;

  Quiz({
    required this.questions,
    required this.quizName,
  });

  factory Quiz.fromJson(String str) => Quiz.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Quiz.fromMap(Map<String, dynamic> json) => Quiz(
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromMap(x))),
        quizName: json["quizName"],
      );

  Map<String, dynamic> toMap() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toMap())),
        "quizName": quizName,
      };

  @override
  String toString() {
    return "$questions    ,  $quizName";
  }
}
