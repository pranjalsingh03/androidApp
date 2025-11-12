class CurrentClassModel {
  final ClassInfo className;
  final SubjectInfo subject;
  final PeriodInfo period;
  final String id;

  CurrentClassModel({
    required this.className,
    required this.subject,
    required this.period,
    required this.id,
  });

  factory CurrentClassModel.fromJson(Map<String, dynamic> json) {
    return CurrentClassModel(
      className: ClassInfo.fromJson(json['className']),
      subject: SubjectInfo.fromJson(json['subject']),
      period: PeriodInfo.fromJson(json['period']),
      id: json['_id'],
    );
  }
}

class ClassInfo {
  final String id;
  final String className;
  final String section;

  ClassInfo({
    required this.id,
    required this.className,
    required this.section,
  });

  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    return ClassInfo(
      id: json['_id'],
      className: json['sclassName'],
      section: json['section'],
    );
  }
}

class SubjectInfo {
  final String id;
  final String subjectName;

  SubjectInfo({
    required this.id,
    required this.subjectName,
  });

  factory SubjectInfo.fromJson(Map<String, dynamic> json) {
    return SubjectInfo(
      id: json['_id'],
      subjectName: json['subName'],
    );
  }
}

class PeriodInfo {
  final String id;
  final String name;
  final String startTime;
  final String endTime;

  PeriodInfo({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  factory PeriodInfo.fromJson(Map<String, dynamic> json) {
    return PeriodInfo(
      id: json['_id'],
      name: json['name'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}
