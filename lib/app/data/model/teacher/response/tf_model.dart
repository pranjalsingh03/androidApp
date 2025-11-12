// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TfModel {
  final String subject;
  final String chapter;
  final String topic;
  final List<Question> questions;
  final String level;
  final String id;

  TfModel({
    required this.subject,
    required this.chapter,
    required this.topic,
    required this.questions,
    required this.level,
    required this.id,
  });

  TfModel copyWith({
    String? subject,
    String? chapter,
    String? topic,
    List<Question>? questions,
    String? level,
    String? id,
  }) {
    return TfModel(
      subject: subject ?? this.subject,
      chapter: chapter ?? this.chapter,
      topic: topic ?? this.topic,
      questions: questions ?? this.questions,
      level: level ?? this.level,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject': subject,
      'chapter': chapter,
      'topic': topic,
      'questions': questions.map((x) => x.toMap()).toList(),
      'level': level,
      '_id': id,
    };
  }

  factory TfModel.fromMap(Map<String, dynamic> map) {
    return TfModel(
      subject: map['subject'] as String,
      chapter: map['chapter'] as String,
      topic: map['topic'] as String,
      questions: List<Question>.from(
        (map['questions'] as List<dynamic>).map<Question>(
          (x) => Question.fromMap(x as Map<String, dynamic>),
        ),
      ),
      level: map['level'] as String,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TfModel.fromJson(String source) =>
      TfModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TfModel(subject: $subject, chapter: $chapter, topic: $topic, questions: $questions, level: $level, id: $id)';
  }

  @override
  bool operator ==(covariant TfModel other) {
    if (identical(this, other)) return true;

    return other.subject == subject &&
        other.chapter == chapter &&
        other.topic == topic &&
        listEquals(other.questions, questions) &&
        other.level == level &&
        other.id == id;
  }

  @override
  int get hashCode {
    return subject.hashCode ^
        chapter.hashCode ^
        topic.hashCode ^
        questions.hashCode ^
        level.hashCode ^
        id.hashCode;
  }
}

class Question {
  final String question;
  final String correctAnswer;
  final String id;

  Question({
    required this.question,
    required this.correctAnswer,
    required this.id,
  });

  Question copyWith({
    String? question,
    String? correctAnswer,
    String? id,
  }) {
    return Question(
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'correctAnswer': correctAnswer,
      '_id': id,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] as String,
      correctAnswer: map['correctAnswer'] as String,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Question(question: $question, correctAnswer: $correctAnswer, id: $id)';

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.question == question &&
        other.correctAnswer == correctAnswer &&
        other.id == id;
  }

  @override
  int get hashCode => question.hashCode ^ correctAnswer.hashCode ^ id.hashCode;
}
