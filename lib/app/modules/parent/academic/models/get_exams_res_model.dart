class GetExamsResModel {
  bool? success;
  Data? data;
  String? message;

  GetExamsResModel({this.success, this.data, this.message});

  GetExamsResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? totalExams;
  List<Exams>? exams;

  Data({this.totalExams, this.exams});

  Data.fromJson(Map<String, dynamic> json) {
    totalExams = json['totalExams'];
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
        exams!.add(new Exams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalExams'] = this.totalExams;
    if (this.exams != null) {
      data['exams'] = this.exams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exams {
  String? sId;
  String? examName;
  String? date;

  Exams({this.sId, this.examName, this.date});

  Exams.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    examName = json['examName'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['examName'] = this.examName;
    data['date'] = this.date;
    return data;
  }
}
