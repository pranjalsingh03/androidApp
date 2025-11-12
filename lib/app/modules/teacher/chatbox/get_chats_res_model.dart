class GetChatsResModel {
  int? statusCode;
  List<Data>? data;
  String? message;
  bool? success;

  GetChatsResModel({this.statusCode, this.data, this.message, this.success});

  GetChatsResModel.fromJson(Map<String, dynamic> json) {
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
  String? from;
  String? to;
  String? message;

  Data({this.from, this.to, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['message'] = this.message;
    return data;
  }
}
