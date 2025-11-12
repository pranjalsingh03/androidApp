class StudentProfileResModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  StudentProfileResModel({this.statusCode, this.data, this.message, this.success});

  StudentProfileResModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  Basic? basic;
  Academic? academic;

  Data({this.basic, this.academic});

  Data.fromJson(Map<String, dynamic> json) {
    basic = json['basic'] != null ? Basic.fromJson(json['basic']) : null;
    academic = json['academic'] != null ? Academic.fromJson(json['academic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (basic != null) {
      data['basic'] = basic!.toJson();
    }
    if (academic != null) {
      data['academic'] = academic!.toJson();
    }
    return data;
  }
}

class Basic {
  String? name;
  String? email;
  String? gender;
  String? phoneNo;
  String? dob;
  String? fatherName;
  String? motherName;
  String? imageUrl;

  Basic({
    this.name,
    this.email,
    this.gender,
    this.phoneNo,
    this.dob,
    this.fatherName,
    this.motherName,
    this.imageUrl,
  });

  Basic.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    phoneNo = json['phoneNo'];
    dob = json['dob'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['phoneNo'] = phoneNo;
    data['dob'] = dob;
    data['fatherName'] = fatherName;
    data['motherName'] = motherName;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

class Academic {
  String? schoolName;
  String? className;
  String? section;
  int? rollNum;
  int? monthlyFeePayable;
  String? adminPhoneNumber;
  String? adminEmail;
  String? adminAddress;

  Academic({
    this.schoolName,
    this.className,
    this.section,
    this.rollNum,
    this.monthlyFeePayable,
    this.adminPhoneNumber,
    this.adminEmail,
    this.adminAddress,
  });

  Academic.fromJson(Map<String, dynamic> json) {
    schoolName = json['schoolName'];
    if (json['class'] != null) {
      List<String> classParts = json['class'].split(' ');
      className = classParts[0];
      section = classParts.length > 1 ? classParts[1] : null;
    }
    rollNum = json['rollNum'];
    monthlyFeePayable = json['monthlyFeePayable'];
    adminPhoneNumber = json['adminPhoneNumber'];
    adminEmail = json['adminEmail'];
    adminAddress = json['adminAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['schoolName'] = schoolName;
    data['class'] = className != null && section != null ? '$className $section' : className;
    data['rollNum'] = rollNum;
    data['monthlyFeePayable'] = monthlyFeePayable;
    data['adminPhoneNumber'] = adminPhoneNumber;
    data['adminEmail'] = adminEmail;
    data['adminAddress'] = adminAddress;
    return data;
  }
}
