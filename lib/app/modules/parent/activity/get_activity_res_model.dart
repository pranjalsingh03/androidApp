class GetActivityResModel {
  int? statusCode;
  List<Data>? data;
  String? message;
  bool? success;

  GetActivityResModel({this.statusCode, this.data, this.message, this.success});

  GetActivityResModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class Data {
  String? id;
  String? subjectName;
  String? description;
  String? periodNumber;
  String? teacherName;

  Data({this.id, this.subjectName, this.description, this.periodNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    subjectName = json['subjectName'];
    description = json['description'];
    periodNumber = json['periodNumber'];
    teacherName = json['teacherName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['subjectName'] = subjectName;
    data['description'] = description;
    data['periodNumber'] = periodNumber;
    data['teacherName'] = teacherName;
    return data;
  }
}