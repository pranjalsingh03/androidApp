import 'package:get/get_connect/http/src/response/response.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';

class AttendanceRepo {
  static ApiClient apiClient = ApiClient();

  static Future<Response> getClass() async {
    var response = await apiClient.get(ApiConstants.getClass);
    return response;
  }
}
