import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';

class TimetableRepo {
  static Future<Map<String, dynamic>?> getTimetableByDay(String day) async {
    final response = await ApiClient().post(
      ApiConstants.teacherGetScheduleByDay,
      baseUrl: ApiConstants.apiBaseUrlNew,
      {"day": day},
    );
    if (response.isOk) {
      return response.body;
    } else {
      return null;
    }
  }
}