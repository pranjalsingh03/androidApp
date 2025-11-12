import 'overall_attendance_analysis_res_model.dart';

class FilteredAttendanceAnalysisResModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  FilteredAttendanceAnalysisResModel(
      {this.statusCode, this.data, this.message, this.success});

  FilteredAttendanceAnalysisResModel.fromJson(Map<String, dynamic> json) {
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
  int? month;
  int? year;
  int? present;
  int? absent;
  int? leave;

  Data({this.month, this.year, this.present, this.absent, this.leave, });

  Data.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    present = json['present'];
    absent = json['absent'];
    leave = json['leave'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['leave'] = this.leave;
    
    return data;
  }
}
