import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/model/teacher/response/teacher_profile_model.dart';

class TeacherProfileRepository {
  static ApiClient apiClient = ApiClient();

  static Future<
      (
        bool success,
        TeacherProfileModel? teacherProfileModel,
        String message
      )> getTeacherProfile() async {
    var res = await apiClient.get(ApiConstants.teacherProfile, passToken: true, baseUrl: "https://sheshya-backend-deployed-529940359558.asia-south1.run.app");

    if (res.statusCode == 200) {
      return (
        true,
        TeacherProfileModel.fromMap(res.body["data"] as Map<String, dynamic>),
        res.body["message"] as String
      );
    } else {
      return (false, null, res.body["message"] as String);
    }
  }
}
