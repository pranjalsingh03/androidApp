class ParentLoginVerifyResModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  ParentLoginVerifyResModel(
      {this.statusCode, this.data, this.message, this.success});

  ParentLoginVerifyResModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null
        ? Data.fromJson(json['data'], json['accessToken'])
        : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class Data {
  String? accessToken;
  Student? student;

  Data({this.accessToken, this.student});

  Data.fromJson(Map<String, dynamic> json, String? token) {
    accessToken = token;
    student = json != null ? Student.fromJson(json) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (student != null) {
      data['student'] = student!.toJson();
    }
    data['accessToken'] = accessToken;
    return data;
  }
}

class Student {
  String? sId;
  String? name;
  int? rollNum;
  String? email;
  String? gender;
  String? address;
  String? phoneNo;
  String? sclassName;
  String? image;
  String? dob;
  String? school;
  String? role;
  ParentDetails? parentDetails;

  Student({
    this.sId,
    this.name,
    this.rollNum,
    this.email,
    this.gender,
    this.address,
    this.phoneNo,
    this.sclassName,
    this.image,
    this.dob,
    this.school,
    this.role,
    this.parentDetails,
  });

  Student.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    rollNum = json['rollNum'];
    email = json['email'];
    gender = json['gender'];
    address = json['address'];
    phoneNo = json['phoneNo'];
    sclassName = json['sclassName'];
    image = json['image'];
    dob = json['dob'];
    school = json['school'];
    role = json['role'];
    parentDetails = json['parentDetails'] != null
        ? ParentDetails.fromJson(json['parentDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['rollNum'] = rollNum;
    data['email'] = email;
    data['gender'] = gender;
    data['address'] = address;
    data['phoneNo'] = phoneNo;
    data['sclassName'] = sclassName;
    data['image'] = image;
    data['dob'] = dob;
    data['school'] = school;
    data['role'] = role;
    if (parentDetails != null) {
      data['parentDetails'] = parentDetails!.toJson();
    }
    return data;
  }
}

class ParentDetails {
  String? fatherName;
  String? motherName;
  String? fatherPhoneNo;
  String? motherPhoneNo;
  String? occupation;

  ParentDetails({
    this.fatherName,
    this.motherName,
    this.fatherPhoneNo,
    this.motherPhoneNo,
    this.occupation,
  });

  ParentDetails.fromJson(Map<String, dynamic> json) {
    fatherName = json['fatherDetails']?['name'];
    motherName = json['motherDetails']?['name'];
    fatherPhoneNo = json['fatherDetails']?['phoneNo'];
    motherPhoneNo = json['motherDetails']?['phoneNo'];
    occupation = json['fatherDetails']?['occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fatherName'] = fatherName;
    data['motherName'] = motherName;
    data['fatherPhoneNo'] = fatherPhoneNo;
    data['motherPhoneNo'] = motherPhoneNo;
    data['occupation'] = occupation;
    return data;
  }
}
