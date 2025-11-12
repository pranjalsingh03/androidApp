class StudentModel {
  final int statusCode;
  final Data data;
  final String message;
  final bool success;

  StudentModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });
}

class Data {
  final String id;
  final String name;
  final int rollNum;
  final String gender;
  final String address;
  final String phoneNo;
  final SclassName sclassName;
  final School school;
  final String role;
  final List<dynamic> extraActivity;
  final List<dynamic> examResult;
  final List<dynamic> attendance;
  final List<dynamic> achievements;
  final List<dynamic> academicPerformance;
  final int v;
  final String createdAt;
  final String updatedAt;

  Data({
    required this.id,
    required this.name,
    required this.rollNum,
    required this.gender,
    required this.address,
    required this.phoneNo,
    required this.sclassName,
    required this.school,
    required this.role,
    required this.extraActivity,
    required this.examResult,
    required this.attendance,
    required this.achievements,
    required this.academicPerformance,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });
}

class School {
  final String id;
  final String name;
  final String address;
  final String schoolCode;
  final String board;
  final String admin;
  final List<dynamic> finances;
  final List<dynamic> employees;
  final List<dynamic> students;
  final List<dynamic> events;
  final List<dynamic> notifications;
  final List<dynamic> notice;
  final List<dynamic> certificates;
  final List<dynamic> certificateTemplete;
  final String createdAt;
  final String updatedAt;
  final int v;
  final SchoolSchedule schoolSchedule;
  final String checkInTime;
  final String checkOutTime;
  final String closingTime;
  final String openingTime;

  School({
    required this.id,
    required this.name,
    required this.address,
    required this.schoolCode,
    required this.board,
    required this.admin,
    required this.finances,
    required this.employees,
    required this.students,
    required this.events,
    required this.notifications,
    required this.notice,
    required this.certificates,
    required this.certificateTemplete,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.schoolSchedule,
    required this.checkInTime,
    required this.checkOutTime,
    required this.closingTime,
    required this.openingTime,
  });
}

class SchoolSchedule {
  final List<Period> periods;

  SchoolSchedule({
    required this.periods,
  });
}

class Period {
  final String name;
  final String startTime;
  final String endTime;
  final String id;

  Period({
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.id,
  });
}

class SclassName {
  final String id;
  final List<String> sclassName;
  final String section;
  final String school;
  final List<dynamic> subjects;
  final String createdAt;
  final String updatedAt;
  final int v;

  SclassName({
    required this.id,
    required this.sclassName,
    required this.section,
    required this.school,
    required this.subjects,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}
