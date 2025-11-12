import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/model/teacher/response/teacher_notification_model.dart';

class TeacherNotificationRepository {
  static ApiClient apiClient = ApiClient();

  static Future<TeacherNotificationModel> getTeacherAllNotification() async {
    var res = await apiClient.get(ApiConstants.teacherNotification);
    return TeacherNotificationModel.fromJson(res.body);
  }

  static Future<Map<String, dynamic>> getTeacherNotification({
    required String notificationId,
  }) async {
    var res = await apiClient
        .get("${ApiConstants.teacherNotification}/$notificationId");
    return res.body;
  }
}
