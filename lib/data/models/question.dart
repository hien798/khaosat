// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

List<Question> questionFromJson(String str) => List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  Question({
    this.title,
    this.question,
    this.type,
    this.answers,
    this.result,
  });

  final String title;
  final String question;
  final String type;
  final List<String> answers;
  final dynamic result;

  Question copyWith({
    String title,
    String question,
    String type,
    List<String> answers,
    dynamic result,
  }) =>
      Question(
        title: title ?? this.title,
        question: question ?? this.question,
        type: type ?? this.type,
        answers: answers ?? this.answers,
        result: result ?? this.result,
      );

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    title: json["title"] == null ? null : json["title"],
    question: json["question"] == null ? null : json["question"],
    type: json["type"] == null ? null : json["type"],
    answers: json["answers"] == null ? null : List<String>.from(json["answers"].map((x) => x)),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "question": question == null ? null : question,
    "type": type == null ? null : type,
    "answers": answers == null ? null : List<dynamic>.from(answers.map((x) => x)),
    "result": result,
  };
}
