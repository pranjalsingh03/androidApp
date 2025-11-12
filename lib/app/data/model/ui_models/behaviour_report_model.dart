import 'dart:convert';

class BehaviourReportModel {
  final String title;
  final String submittedBy;
  final String date;
  final String content;
  BehaviourReportModel({
    required this.title,
    required this.submittedBy,
    required this.date,
    required this.content,
  });

  BehaviourReportModel copyWith({
    String? title,
    String? submittedBy,
    String? date,
    String? content,
  }) {
    return BehaviourReportModel(
      title: title ?? this.title,
      submittedBy: submittedBy ?? this.submittedBy,
      date: date ?? this.date,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'submittedBy': submittedBy,
      'date': date,
      'content': content,
    };
  }

  factory BehaviourReportModel.fromMap(Map<String, dynamic> map) {
    return BehaviourReportModel(
      title: map['title'] as String,
      submittedBy: map['submittedBy'] as String,
      date: map['date'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BehaviourReportModel.fromJson(String source) =>
      BehaviourReportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BehaviourReportModel(title: $title, submittedBy: $submittedBy, date: $date, content: $content)';
  }

  @override
  bool operator ==(covariant BehaviourReportModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.submittedBy == submittedBy &&
        other.date == date &&
        other.content == content;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        submittedBy.hashCode ^
        date.hashCode ^
        content.hashCode;
  }
}
