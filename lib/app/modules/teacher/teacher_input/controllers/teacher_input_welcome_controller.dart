import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';

class TeacherInputController extends GetxController {
  String displayName = "";
  @override
  void onInit() {
    super.onInit();

    displayName = Get.find<TeacherProfileController>().displayName;
    update();
  }
}
