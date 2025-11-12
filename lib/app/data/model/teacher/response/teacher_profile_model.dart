import 'dart:convert';

class TeacherProfileModel {
  final String id;
  final String name;
  final String email;
  final String phoneNo;
  final String? gender; // Nullable
  final String? dob; // Nullable
  final String? address; // Nullable
  final Salary salary;
  final String? joiningDate; // Nullable
  final String? imageUrl; // Nullable
  final String role;
  final String school;
  final bool isClassTeacher;
  final List<ClassTeacher> classTeacher; // List of ClassTeacher objects
  final int? totalClasses;
  final List<Schedule> schedule;
  final List<TeachSubject> teachSubject; // List of TeachSubject objects
  final List<String> teachSclass; // List of ObjectId references
  final List<Attendance> attendance;
  final String? refreshToken; // Nullable
  final bool isDataComplete;

  TeacherProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNo,
    this.gender,
    this.dob,
    this.address,
    required this.salary,
    this.joiningDate,
    this.totalClasses,
    this.imageUrl,
    required this.role,
    required this.school,
    required this.isClassTeacher,
    required this.classTeacher,
    required this.schedule,
    required this.teachSubject,
    required this.teachSclass,
    required this.attendance,
    this.refreshToken,
    required this.isDataComplete,
  });

  TeacherProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNo,
    String? gender,
    String? dob,
    String? address,
    Salary? salary,
    String? joiningDate,
    String? imageUrl,
    String? role,
    String? school,
    bool? isClassTeacher,
    int? totalClasses,
    List<ClassTeacher>? classTeacher,
    List<Schedule>? schedule,
    List<TeachSubject>? teachSubject,
    List<String>? teachSclass,
    List<Attendance>? attendance,
    String? refreshToken,
    bool? isDataComplete,
  }) {
    return TeacherProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      salary: salary ?? this.salary,
      joiningDate: joiningDate ?? this.joiningDate,
      imageUrl: imageUrl ?? this.imageUrl,
      role: role ?? this.role,
      school: school ?? this.school,
      isClassTeacher: isClassTeacher ?? this.isClassTeacher,
      totalClasses: totalClasses ?? this.totalClasses,
      classTeacher: classTeacher ?? this.classTeacher,
      schedule: schedule ?? this.schedule,
      teachSubject: teachSubject ?? this.teachSubject,
      teachSclass: teachSclass ?? this.teachSclass,
      attendance: attendance ?? this.attendance,
      refreshToken: refreshToken ?? this.refreshToken,
      isDataComplete: isDataComplete ?? this.isDataComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'gender': gender,
      'dob': dob,
      'address': address,
      'salary': salary.toMap(),
      'joiningDate': joiningDate,
      'imageUrl': imageUrl,
      'role': role,
      'school': school,
      'isClassTeacher': isClassTeacher,
      'classTeacher': classTeacher.map((x) => x.toMap()).toList(),
      'totalClasses': totalClasses,
      'schedule': schedule.map((x) => x.toMap()).toList(),
      'teachSubject': teachSubject.map((x) => x.toMap()).toList(),
      'teachSclass': teachSclass,
      'attendance': attendance.map((x) => x.toMap()).toList(),
      'refreshToken': refreshToken,
      'isDataComplete': isDataComplete,
    };
  }

  factory TeacherProfileModel.fromMap(Map<String, dynamic> map) {
    return TeacherProfileModel(
      id: map['_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phoneNo: map['phoneNo'] as String? ?? '',
      gender: map['gender'] as String?,
      dob: map['dob'] as String?,
      address: map['address'] as String?,
      salary: map['salary'] != null
          ? Salary.fromMap(Map<String, dynamic>.from(map['salary'] as Map))
          : Salary(basic: 0, allowances: 0, deductions: 0), // Default value
      joiningDate: map['joiningDate'] as String?,
      imageUrl: map['imageUrl'] as String?,
      role: map['role'] as String? ?? 'Teacher',
      school: map['school'] as String? ?? '',
      isClassTeacher: map['isClassTeacher'] as bool? ?? false,
      classTeacher: (map['classTeacher'] as List?)
              ?.map((x) => ClassTeacher.fromMap(Map<String, dynamic>.from(x as Map)))
              .toList() ??
          [],
      schedule: (map['schedule'] as List?)
              ?.map((x) => Schedule.fromMap(Map<String, dynamic>.from(x as Map)))
              .toList() ??
          [],
      teachSubject: (map['teachSubject'] as List?)
              ?.map((x) => TeachSubject.fromMap(Map<String, dynamic>.from(x as Map)))
              .toList() ??
          [],
      teachSclass: (map['teachSclass'] as List?)
              ?.map((x) => x as String)
              .toList() ??
          [],
      totalClasses: map['totalClasses'] as int? ?? 0,
      attendance: (map['attendance'] as List?)
              ?.map((x) => Attendance.fromMap(Map<String, dynamic>.from(x as Map)))
              .toList() ??
          [],
      refreshToken: map['refreshToken'] as String?,
      isDataComplete: map['isDataComplete'] as bool? ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherProfileModel.fromJson(String source) =>
      TeacherProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherProfileModel(id: $id, name: $name, email: $email, phoneNo: $phoneNo, gender: $gender, dob: $dob, address: $address, salary: $salary, joiningDate: $joiningDate, imageUrl: $imageUrl, role: $role, school: $school, isClassTeacher: $isClassTeacher, classTeacher: $classTeacher, schedule: $schedule, teachSubject: $teachSubject, teachSclass: $teachSclass, attendance: $attendance, refreshToken: $refreshToken, isDataComplete: $isDataComplete,$totalClasses: $totalClasses)';
  }

  @override
  bool operator ==(covariant TeacherProfileModel other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phoneNo == phoneNo &&
        other.gender == gender &&
        other.dob == dob &&
        other.address == address &&
        other.salary == salary &&
        other.joiningDate == joiningDate &&
        other.imageUrl == imageUrl &&
        other.role == role &&
        other.school == school &&
        other.isClassTeacher == isClassTeacher &&
        other.classTeacher == classTeacher &&
        other.schedule == schedule &&
        other.teachSubject == teachSubject &&
        other.teachSclass == teachSclass &&
        other.attendance == attendance &&
        other.refreshToken == refreshToken &&
        other.totalClasses == totalClasses &&
        other.isDataComplete == isDataComplete;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNo.hashCode ^
        gender.hashCode ^
        dob.hashCode ^
        address.hashCode ^
        salary.hashCode ^
        joiningDate.hashCode ^
        imageUrl.hashCode ^
        role.hashCode ^
        school.hashCode ^
        isClassTeacher.hashCode ^
        classTeacher.hashCode ^
        totalClasses.hashCode ^
        schedule.hashCode ^
        teachSubject.hashCode ^
        teachSclass.hashCode ^
        attendance.hashCode ^
        refreshToken.hashCode ^
        isDataComplete.hashCode;
  }

  get classDetails => null;

}

class Salary {
  final int basic;
  final int allowances;
  final int deductions;

  Salary({
    required this.basic,
    required this.allowances,
    required this.deductions,
  });

  Salary copyWith({
    int? basic,
    int? allowances,
    int? deductions,
  }) {
    return Salary(
      basic: basic ?? this.basic,
      allowances: allowances ?? this.allowances,
      deductions: deductions ?? this.deductions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'basic': basic,
      'allowances': allowances,
      'deductions': deductions,
    };
  }

  factory Salary.fromMap(Map<String, dynamic> map) {
    return Salary(
      basic: map['basic'] as int? ?? 0,
      allowances: map['allowances'] as int? ?? 0,
      deductions: map['deductions'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Salary.fromJson(String source) =>
      Salary.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Salary(basic: $basic, allowances: $allowances, deductions: $deductions)';

  @override
  bool operator ==(covariant Salary other) {
    if (identical(this, other)) return true;
    return other.basic == basic &&
        other.allowances == allowances &&
        other.deductions == deductions;
  }

  @override
  int get hashCode => basic.hashCode ^ allowances.hashCode ^ deductions.hashCode;
}

class Schedule {
  final String day;
  final String className;
  final String subject;
  final String periodId;
  final bool? isFree;
  final bool isRecorded;

  Schedule({
    required this.day,
    required this.className,
    required this.subject,
    required this.periodId,
    this.isFree,
    required this.isRecorded,
  });

  Schedule copyWith({
    String? day,
    String? className,
    String? subject,
    String? periodId,
    bool? isFree,
    bool? isRecorded,
  }) {
    return Schedule(
      day: day ?? this.day,
      className: className ?? this.className,
      subject: subject ?? this.subject,
      periodId: periodId ?? this.periodId,
      isFree: isFree ?? this.isFree,
      isRecorded: isRecorded ?? this.isRecorded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'className': className,
      'subject': subject,
      'periodId': periodId,
      'isFree': isFree,
      'isRecorded': isRecorded,
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      day: map['day'] as String? ?? '',
      className: map['className'] as String? ?? '',
      subject: map['subject'] as String? ?? '',
      periodId: map['periodId'] as String? ?? '',
      isFree: map['isFree'] as bool?,
      isRecorded: map['isRecorded'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Schedule(day: $day, className: $className, subject: $subject, periodId: $periodId, isFree: $isFree, isRecorded: $isRecorded)';

  @override
  bool operator ==(covariant Schedule other) {
    if (identical(this, other)) return true;
    return other.day == day &&
        other.className == className &&
        other.subject == subject &&
        other.periodId == periodId &&
        other.isFree == isFree &&
        other.isRecorded == isRecorded;
  }

  @override
  int get hashCode =>
      day.hashCode ^
      className.hashCode ^
      subject.hashCode ^
      periodId.hashCode ^
      isFree.hashCode ^
      isRecorded.hashCode;
}

class Attendance {
  final DateTime date;
  final String status;
  final String? loginTime;

  Attendance({
    required this.date,
    required this.status,
    this.loginTime,
  });

  Attendance copyWith({
    DateTime? date,
    String? status,
    String? loginTime,
  }) {
    return Attendance(
      date: date ?? this.date,
      status: status ?? this.status,
      loginTime: loginTime ?? this.loginTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'status': status,
      'loginTime': loginTime,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      date: DateTime.parse(map['date'] as String),
      status: map['status'] as String? ?? '',
      loginTime: map['loginTime'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Attendance(date: $date, status: $status, loginTime: $loginTime)';

  @override
  bool operator ==(covariant Attendance other) {
    if (identical(this, other)) return true;
    return other.date == date &&
        other.status == status &&
        other.loginTime == loginTime;
  }

  @override
  int get hashCode => date.hashCode ^ status.hashCode ^ loginTime.hashCode;
}

class ClassTeacher {
  final String id;
  final ClassId classId;
  final String section;

  ClassTeacher({
    required this.id,
    required this.classId,
    required this.section,
  });

  ClassTeacher copyWith({
    String? id,
    ClassId? classId,
    String? section,
  }) {
    return ClassTeacher(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      section: section ?? this.section,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'classId': classId.toMap(),
      'section': section,
    };
  }

  factory ClassTeacher.fromMap(Map<String, dynamic> map) {
    return ClassTeacher(
      id: map['_id'] as String? ?? '',
      classId: ClassId.fromMap(Map<String, dynamic>.from(map['classId'] as Map)),
      section: map['section'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassTeacher.fromJson(String source) =>
      ClassTeacher.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ClassTeacher(id: $id, classId: $classId, section: $section)';

  @override
  bool operator ==(covariant ClassTeacher other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.classId == classId &&
        other.section == section;
  }

  @override
  int get hashCode => id.hashCode ^ classId.hashCode ^ section.hashCode;
}

class ClassId {
  final String id;
  final String className;

  ClassId({
    required this.id,
    required this.className,
  });

  ClassId copyWith({
    String? id,
    String? className,
  }) {
    return ClassId(
      id: id ?? this.id,
      className: className ?? this.className,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'className': className,
    };
  }

  factory ClassId.fromMap(Map<String, dynamic> map) {
    return ClassId(
      id: map['_id'] as String? ?? '',
      className: map['className'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassId.fromJson(String source) =>
      ClassId.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ClassId(id: $id, className: $className)';

  @override
  bool operator ==(covariant ClassId other) {
    if (identical(this, other)) return true;
    return other.id == id && other.className == className;
  }

  @override
  int get hashCode => id.hashCode ^ className.hashCode;
}

class TeachSubject {
  final String id;
  final String subName;

  TeachSubject({
    required this.id,
    required this.subName,
  });

  TeachSubject copyWith({
    String? id,
    String? subName,
  }) {
    return TeachSubject(
      id: id ?? this.id,
      subName: subName ?? this.subName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'subName': subName,
    };
  }

  factory TeachSubject.fromMap(Map<String, dynamic> map) {
    return TeachSubject(
      id: map['_id'] as String? ?? '',
      subName: map['subName'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeachSubject.fromJson(String source) =>
      TeachSubject.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => ' $subName';

  @override
  bool operator ==(covariant TeachSubject other) {
    if (identical(this, other)) return true;
    return other.id == id && other.subName == subName;
  }

  @override
  int get hashCode => id.hashCode ^ subName.hashCode;
}