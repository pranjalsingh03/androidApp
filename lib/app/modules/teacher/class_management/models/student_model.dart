class StudentModel {
  final String? name;
  final int? rollNum;
  final String? className;
  final String? section;
  final String? dob;
  final String? email;
  final String? phoneNo;
  final ParentDetails? parentDetails;
  final List<ExtraCurricular>? extraCurricular;
  final String? imageUrl;

  StudentModel({
    this.name,
    this.rollNum,
    this.className,
    this.section,
    this.dob,
    this.email,
    this.phoneNo,
    this.parentDetails,
    this.extraCurricular,
    this.imageUrl,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'] as String?,
      rollNum: json['rollNum'] as int?,
      className: json['className'] as String?,
      section: json['section'] as String?,
      dob: json['dob'] as String?,
      email: json['email'] as String?,
      phoneNo: json['phoneNo'] as String?,
      parentDetails: json['parentDetails'] != null
          ? ParentDetails.fromJson(json['parentDetails'])
          : null,
      extraCurricular: json['extraCurricular'] != null
          ? (json['extraCurricular'] as List)
              .map((e) => ExtraCurricular.fromJson(e))
              .toList()
          : [],
      imageUrl: json['imageUrl'] as String?,
    );
  }
}

class ParentDetails {
  final FatherDetails? fatherDetails;
  final MotherDetails? motherDetails;

  ParentDetails({
    this.fatherDetails,
    this.motherDetails,
  });

  factory ParentDetails.fromJson(Map<String, dynamic> json) {
    return ParentDetails(
      fatherDetails: json['fatherDetails'] != null
          ? FatherDetails.fromJson(json['fatherDetails'])
          : null,
      motherDetails: json['motherDetails'] != null
          ? MotherDetails.fromJson(json['motherDetails'])
          : null,
    );
  }
}

class FatherDetails {
  final String? name;
  final String? phoneNo;
  final String? occupation;

  FatherDetails({
    this.name,
    this.phoneNo,
    this.occupation,
  });

  factory FatherDetails.fromJson(Map<String, dynamic> json) {
    return FatherDetails(
      name: json['name'] as String?,
      phoneNo: json['phoneNo'] as String?,
      occupation: json['occupation'] as String?,
    );
  }
}

class MotherDetails {
  final String? name;
  final String? phoneNo;
  final String? occupation;

  MotherDetails({
    this.name,
    this.phoneNo,
    this.occupation,
  });

  factory MotherDetails.fromJson(Map<String, dynamic> json) {
    return MotherDetails(
      name: json['name'] as String?,
      phoneNo: json['phoneNo'] as String?,
      occupation: json['occupation'] as String?,
    );
  }
}

class ExtraCurricular {
  final String? activityName;
  final String? activityDate;
  final String? activityDetails;

  ExtraCurricular({
    this.activityName,
    this.activityDate,
    this.activityDetails,
  });

  factory ExtraCurricular.fromJson(Map<String, dynamic> json) {
    return ExtraCurricular(
      activityName: json['activityName'] as String?,
      activityDate: json['activityDate'] as String?,
      activityDetails: json['activityDetails'] as String?,
    );
  }
}