import 'dart:convert';

import 'package:flutter/foundation.dart';

class AiChatReqModel {
  final String query;
  final List<String> history;
  AiChatReqModel({
    required this.query,
    required this.history,
  });

  AiChatReqModel copyWith({
    String? query,
    List<String>? history,
  }) {
    return AiChatReqModel(
      query: query ?? this.query,
      history: history ?? this.history,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'query': query,
      'history': history,
    };
  }

  factory AiChatReqModel.fromMap(Map<String, dynamic> map) {
    return AiChatReqModel(
      query: map['query'] as String,
      history: List<String>.from((map['history'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory AiChatReqModel.fromJson(String source) =>
      AiChatReqModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AiChatReqModel(query: $query, history: $history)';

  @override
  bool operator ==(covariant AiChatReqModel other) {
    if (identical(this, other)) return true;

    return other.query == query && listEquals(other.history, history);
  }

  @override
  int get hashCode => query.hashCode ^ history.hashCode;
}
