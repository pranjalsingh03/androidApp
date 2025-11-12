class GetNotificationStudentsResModel {
  int? statusCode;
  List<Data>? data;
  String? message;
  bool? success;

  GetNotificationStudentsResModel(
      {this.statusCode, this.data, this.message, this.success});

  GetNotificationStudentsResModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? message;
  String? date;
  String? time;

  Data({this.sId, this.title, this.message, this.date, this.time});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    message = json['message'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
