import 'dart:convert';

class NotificationModel {
  final String title;
  final String date;
  final String content;
  NotificationModel({
    required this.title,
    required this.date,
    required this.content,
  });

  NotificationModel copyWith({
    String? title,
    String? date,
    String? content,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      date: date ?? this.date,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'date': date,
      'content': content,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      date: map['date'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NotificationModel(title: $title, date: $date, content: $content)';

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.date == date &&
        other.content == content;
  }

  @override
  int get hashCode => title.hashCode ^ date.hashCode ^ content.hashCode;
}
