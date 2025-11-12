import 'dart:convert';
import 'package:flutter/foundation.dart';

class McqModel {
  final String assignmentName;
  final String subject;
  final String chapter;
  final String topic;
  final String level;
  final List<Question> questions;
  final int duration;
  final String id;

  McqModel({
    required this.assignmentName,
    required this.subject,
    required this.chapter,
    required this.topic,
    required this.level,
    required this.questions,
    required this.duration,
    required this.id,
  });

  factory McqModel.fromMap(Map<String, dynamic> map) {
    return McqModel(
      assignmentName: map['assignmentName'] as String,
      subject: map['subject'] as String,
      chapter: map['chapter'] as String,
      topic: map['topic'] as String,
      level: map['level'] as String,
      questions: List<Question>.from(
        (map['questions'] as List<dynamic>).map<Question>(
          (x) => Question.fromMap(x as Map<String, dynamic>),
        ),
      ),
      duration: map['duration'] as int,
      id: map['_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'assignmentName': assignmentName,
      'subject': subject,
      'chapter': chapter,
      'topic': topic,
      'level': level,
      'questions': questions.map((x) => x.toMap()).toList(),
      'duration': duration,
      '_id': id,
    };
  }

  String toJson() => json.encode(toMap());

  factory McqModel.fromJson(String source) =>
      McqModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String id;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.id,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] as String,
      options: List<String>.from(map['options'] as List<dynamic>),
      correctAnswer: map['correctAnswer'] as String,
      id: map['_id'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      '_id': id,
    };
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);
}
