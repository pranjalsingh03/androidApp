class GetAllTeachersResModel {
  int? statusCode;
  List<Data>? data;
  String? message;
  bool? success;

  GetAllTeachersResModel(
      {this.statusCode, this.data, this.message, this.success});

  GetAllTeachersResModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? phoneNo;
  String? role;
  String? school;
  List<String>? teachSubject;
  // List<String>? teachSclass;
  // String? section;
  // List<Attendance>? attendance;
  // List<Null>? tempSchedule;
  // int? iV;
  // String? createdAt;
  // String? updatedAt;
  // String? refreshToken;
  // bool? isDataComplete;
  // bool? isDataInput;
  // String? dob;
  // String? gender;
  // String? image;
  // String? joiningDate;
  // int? totalClasses;
  // List<Schedule>? schedule;
  // String? otp;

  Data(
      {this.sId,
        this.name,
        this.email,
        this.phoneNo,
        this.role,
        this.school,
        this.teachSubject,
        // this.teachSclass,
        // this.section,
        // this.attendance,
        // this.tempSchedule,
        // this.iV,
        // this.createdAt,
        // this.updatedAt,
        // this.refreshToken,
        // this.isDataComplete,
        // this.isDataInput,
        // this.dob,
        // this.gender,
        // this.image,
        // this.joiningDate,
        // this.totalClasses,
        // this.schedule,
        // this.otp
      });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    role = json['role'];
    school = json['school'];
    teachSubject = (json['teachSubject']!=null) ? json['teachSubject'].cast<String>() : null;
    // teachSclass = json['teachSclass'].cast<String>();
    // section = json['section'];
    // if (json['attendance'] != null) {
    //   attendance = <Attendance>[];
    //   json['attendance'].forEach((v) {
    //     attendance!.add(new Attendance.fromJson(v));
    //   });
    // }
    // if (json['tempSchedule'] != null) {
    //   tempSchedule = <Null>[];
    //   json['tempSchedule'].forEach((v) {
    //     tempSchedule!.add(new Null.fromJson(v));
    //   });
    // }
    // iV = json['__v'];
    // createdAt = json['createdAt'];
    // updatedAt = json['updatedAt'];
    // refreshToken = json['refreshToken'];
    // isDataComplete = json['isDataComplete'];
    // isDataInput = json['isDataInput'];
    // dob = json['dob'];
    // gender = json['gender'];
    // image = json['image'];
    // joiningDate = json['joiningDate'];
    // totalClasses = json['totalClasses'];
    // if (json['schedule'] != null) {
    //   schedule = <Schedule>[];
    //   json['schedule'].forEach((v) {
    //     schedule!.add(new Schedule.fromJson(v));
    //   });
    // }
    // otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['role'] = this.role;
    data['school'] = this.school;
    data['teachSubject'] = this.teachSubject;
    // data['teachSclass'] = this.teachSclass;
    // data['section'] = this.section;
    // if (this.attendance != null) {
    //   data['attendance'] = this.attendance!.map((v) => v.toJson()).toList();
    // }
    // if (this.tempSchedule != null) {
    //   data['tempSchedule'] = this.tempSchedule!.map((v) => v.toJson()).toList();
    // }
    // data['__v'] = this.iV;
    // data['createdAt'] = this.createdAt;
    // data['updatedAt'] = this.updatedAt;
    // data['refreshToken'] = this.refreshToken;
    // data['isDataComplete'] = this.isDataComplete;
    // data['isDataInput'] = this.isDataInput;
    // data['dob'] = this.dob;
    // data['gender'] = this.gender;
    // data['image'] = this.image;
    // data['joiningDate'] = this.joiningDate;
    // data['totalClasses'] = this.totalClasses;
    // if (this.schedule != null) {
    //   data['schedule'] = this.schedule!.map((v) => v.toJson()).toList();
    // }
    // data['otp'] = this.otp;
    return data;
  }
}

class Attendance {
  String? date;
  String? status;
  String? sId;

  Attendance({this.date, this.status, this.sId});

  Attendance.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class Schedule {
  String? day;
  String? className;
  String? subject;
  String? period;
  String? sId;

  Schedule({this.day, this.className, this.subject, this.period, this.sId});

  Schedule.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    className = json['className'];
    subject = json['subject'];
    period = json['period'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['className'] = this.className;
    data['subject'] = this.subject;
    data['period'] = this.period;
    data['_id'] = this.sId;
    return data;
  }
}
