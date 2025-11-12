class GetAcademicPerformanceModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  GetAcademicPerformanceModel(
      {this.statusCode, this.data, this.message, this.success});

  GetAcademicPerformanceModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? subject;
  String? exam;
  int? totalMarks;
  int? marksObtained;
  String? passed;
  String? studentPercentage;
  String? classAveragePercentage;
  String? studentPosition;
  int? highestMarks;
  int? lowestMarks;

  Data(
      {this.subject,
        this.exam,
        this.totalMarks,
        this.marksObtained,
        this.passed,
        this.studentPercentage,
        this.classAveragePercentage,
        this.studentPosition,
        this.highestMarks,
        this.lowestMarks});

  Data.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    exam = json['exam'];
    totalMarks = json['totalMarks'];
    marksObtained = json['marksObtained'];
    passed = json['passed'];
    studentPercentage = json['studentPercentage'];
    classAveragePercentage = json['classAveragePercentage'];
    studentPosition = json['studentPosition'];
    highestMarks = json['highestMarks'];
    lowestMarks = json['lowestMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['exam'] = this.exam;
    data['totalMarks'] = this.totalMarks;
    data['marksObtained'] = this.marksObtained;
    data['passed'] = this.passed;
    data['studentPercentage'] = this.studentPercentage;
    data['classAveragePercentage'] = this.classAveragePercentage;
    data['studentPosition'] = this.studentPosition;
    data['highestMarks'] = this.highestMarks;
    data['lowestMarks'] = this.lowestMarks;
    return data;
  }
}
