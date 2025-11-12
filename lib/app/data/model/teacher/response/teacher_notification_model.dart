class TeacherNotificationModel {
  final bool success;
  final String message;
  final List<TeacherNotificationData> data;

  TeacherNotificationModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TeacherNotificationModel.fromJson(Map<String, dynamic> source) {
    return TeacherNotificationModel(
      success: source['success'] as bool,
      message: source['message'] as String,
      data: List<TeacherNotificationData>.from(
        (source['data'] as List).map<TeacherNotificationData>(
          (x) => TeacherNotificationData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class TeacherNotificationData {
  final String title;
  final String message;
  final String date;

  TeacherNotificationData({
    required this.title,
    required this.message,
    required this.date,
  });

  factory TeacherNotificationData.fromMap(Map<String, dynamic> map) {
    return TeacherNotificationData(
      title: map['title'] as String,
      message: map['message'] as String,
      date: map['date'] as String,
    );
  }
}