import 'dart:convert';

class TeacherTimetableModel {
  final int statusCode;
  final Data data;
  final String message;
  final bool success;

  TeacherTimetableModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory TeacherTimetableModel.fromMap(Map<String, dynamic> map) {
    return TeacherTimetableModel(
      statusCode: map['statusCode'] as int,
      data: Data.fromMap(map['data'] as Map<String, dynamic>),
      message: map['message'] as String,
      success: map['success'] as bool,
    );
  }

  factory TeacherTimetableModel.fromJson(String source) =>
      TeacherTimetableModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class Data {
  final Map<String, List<Day>> days;

  Data({required this.days});

  factory Data.fromMap(Map<String, dynamic> map) {
    Map<String, List<Day>> days = {};
    map.forEach((key, value) {
      if (value is List) {
        days[key] = List<Day>.from(
          (value).map<Day>(
            (x) => Day.fromMap(x as Map<String, dynamic>),
          ),
        );
      }
    });
    return Data(days: days);
  }
}

class Day {
  final ClassName className;
  final Subject subject;
  final Period period;
  final String id;

  Day({
    required this.className,
    required this.subject,
    required this.period,
    required this.id,
  });

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      className: ClassName.fromMap(map['className'] as Map<String, dynamic>),
      subject: Subject.fromMap(map['subject'] as Map<String, dynamic>),
      period: Period.fromMap(map['period'] as Map<String, dynamic>),
      id: map['_id'] as String,
    );
  }
}

class ClassName {
  final String id;
  final String sclassName;
  final String section;

  ClassName({
    required this.id,
    required this.sclassName,
    required this.section,
  });

  factory ClassName.fromMap(Map<String, dynamic> map) {
    return ClassName(
      id: map['_id'] as String,
      sclassName: map['className'] as String,
      section: map['section'] as String,
    );
  }
}

class Period {
  final String id;
  final String name;

  Period({
    required this.id,
    required this.name,
  });

  factory Period.fromMap(Map<String, dynamic> map) {
    return Period(
      id: map['_id'] as String,
      name: map['name'] as String,
    );
  }
}

class Subject {
  final String id;
  final String subName;

  Subject({
    required this.id,
    required this.subName,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['_id'] as String,
      subName: map['subName'] as String,
    );
  }
}