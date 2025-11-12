import 'dart:convert';
import 'package:flutter/foundation.dart';

class SubjectModel {
  final List<Chapter> chapters;
  final String subjectId;
  final String subjectName;

  SubjectModel({
    required this.chapters,
    required this.subjectId,
    required this.subjectName,
  });

  SubjectModel copyWith({
    List<Chapter>? chapters,
    String? subjectId,
    String? subjectName,
  }) {
    return SubjectModel(
      chapters: chapters ?? this.chapters,
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chapters': chapters.map((x) => x.toMap()).toList(),
      'subject_id': subjectId,
      'subject_name': subjectName,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      chapters: List<Chapter>.from(
        (map['chapters'] as List<dynamic>).map<Chapter>(
          (x) => Chapter.fromMap(x as Map<String, dynamic>),
        ),
      ),
      subjectId: map['_id'] as String,
      subjectName: map['subjectName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) =>
      SubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubjectModel(chapters: $chapters, subjectId: $subjectId, subjectName: $subjectName)';

  @override
  bool operator ==(covariant SubjectModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.chapters, chapters) &&
        other.subjectId == subjectId &&
        other.subjectName == subjectName;
  }

  @override
  int get hashCode =>
      chapters.hashCode ^ subjectId.hashCode ^ subjectName.hashCode;
}

class Chapter {
  final String chapterId;
  final String chapterName;
  final List<Topic> topics;

  Chapter({
    required this.chapterId,
    required this.chapterName,
    required this.topics,
  });

  Chapter copyWith({
    String? chapterId,
    String? chapterName,
    List<Topic>? topics,
  }) {
    return Chapter(
      chapterId: chapterId ?? this.chapterId,
      chapterName: chapterName ?? this.chapterName,
      topics: topics ?? this.topics,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chapter_id': chapterId,
      'chapterName': chapterName,
      'topics': topics.map((x) => x.toMap()).toList(),
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      chapterId: map['chapter_id'] as String,
      chapterName: map['chapter_name'] as String,
      topics: List<Topic>.from(
        (map['topics'] as List<dynamic>).map<Topic>(
          (x) => Topic.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Chapter(chapterId: $chapterId, chapterName: $chapterName, topics: $topics)';

  @override
  bool operator ==(covariant Chapter other) {
    if (identical(this, other)) return true;

    return other.chapterId == chapterId &&
        other.chapterName == chapterName &&
        listEquals(other.topics, topics);
  }

  @override
  int get hashCode =>
      chapterId.hashCode ^ chapterName.hashCode ^ topics.hashCode;
}

class Topic {
  final String topicId;
  final String topicName;

  Topic({
    required this.topicId,
    required this.topicName,
  });

  Topic copyWith({
    String? topicId,
    String? topicName,
  }) {
    return Topic(
      topicId: topicId ?? this.topicId,
      topicName: topicName ?? this.topicName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'topic_id': topicId,
      'topic_name': topicName,
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      topicId: map['topic_id'] as String,
      topicName: map['topic_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) =>
      Topic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Topic(topicId: $topicId, topicName: $topicName)';

  @override
  bool operator ==(covariant Topic other) {
    if (identical(this, other)) return true;

    return other.topicId == topicId && other.topicName == topicName;
  }

  @override
  int get hashCode => topicId.hashCode ^ topicName.hashCode;
}
