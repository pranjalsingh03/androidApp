class AllStudentsModel {
  final List<StudentData> data;

  AllStudentsModel({required this.data});

  factory AllStudentsModel.fromJson(Map<String, dynamic> json) {
    return AllStudentsModel(
      data: List<StudentData>.from(
        json['data'].map((x) => StudentData.fromJson(x)),
      ),
    );
  }
}

class StudentData {
  final String studentId;
  final String name;
  final int rollNum;
  final String assignmentId;
  final String imageUrl;

  StudentData({
    required this.studentId,
    required this.name,
    required this.rollNum,
    required this.assignmentId,
    required this.imageUrl,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      studentId: json['studentId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      rollNum: json['rollNum'] as int? ?? 0,
      assignmentId: json['assignmentId'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}