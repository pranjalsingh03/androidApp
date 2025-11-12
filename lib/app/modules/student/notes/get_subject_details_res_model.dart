class GetSubjectDetailsResModel {
  String? message;
  List<Data>? data;
  bool? success;

  GetSubjectDetailsResModel({this.message, this.data, this.success});

  GetSubjectDetailsResModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? id;
  String? subName;
  String? image;

  Data({this.id, this.subName, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subName = json['subName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['subName'] = this.subName;
    data['image'] = this.image;
    return data;
  }
}