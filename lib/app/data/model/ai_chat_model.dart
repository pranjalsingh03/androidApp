import 'dart:convert';

class AiChatModel {
  String message;
  DateTime createdAt;
  bool isCreatedByMe;
  AiChatModel({
    required this.message,
    required this.createdAt,
    required this.isCreatedByMe,
  });

  AiChatModel copyWith({
    String? message,
    DateTime? createdAt,
    bool? isCreatedByMe,
  }) {
    return AiChatModel(
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isCreatedByMe: isCreatedByMe ?? this.isCreatedByMe,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isCreatedByMe': isCreatedByMe,
    };
  }

  factory AiChatModel.fromMap(Map<String, dynamic> map) {
    return AiChatModel(
      message: map['message'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      isCreatedByMe: map['isCreatedByMe'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AiChatModel.fromJson(String source) =>
      AiChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AiChatModel(message: $message, createdAt: $createdAt, isCreatedByMe: $isCreatedByMe)';

  @override
  bool operator ==(covariant AiChatModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.createdAt == createdAt &&
        other.isCreatedByMe == isCreatedByMe;
  }

  @override
  int get hashCode =>
      message.hashCode ^ createdAt.hashCode ^ isCreatedByMe.hashCode;
}
