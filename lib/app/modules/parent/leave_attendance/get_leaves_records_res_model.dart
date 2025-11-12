class GetLeavesRecordResModel {
  String? message;
  List<Data>? data;
  bool? success;

  GetLeavesRecordResModel({this.message, this.data, this.success});

  GetLeavesRecordResModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? date;
  String? reason;

  Data({this.date, this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['reason'] = this.reason;
    return data;
  }
}