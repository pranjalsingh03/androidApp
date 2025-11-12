class OverallAttendanceAnalysisResModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  OverallAttendanceAnalysisResModel(
      {this.statusCode, this.data, this.message, this.success});

  OverallAttendanceAnalysisResModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  int? present;
  int? absent;
  int? leave;

  Data({this.present, this.absent, this.leave});

  Data.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    absent = json['absent'];
    leave = json['leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['leave'] = this.leave;
    return data;
  }
}