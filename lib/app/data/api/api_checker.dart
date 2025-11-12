import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      // Get.find<AuthController>().clearSharedData();
      // Get.offAllNamed(RouteHelper.getSignInRoute());
    } else {
      // showCustomSnackBar(response.statusText);
    }
  }
}
