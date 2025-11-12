import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/ai_chat/controllers/ai_chat_controller.dart';
import 'package:sheshya/app/modules/auth/controllers/auth_controller.dart';
import 'package:sheshya/app/modules/splash/controllers/splash_controller.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/controllers/class_management_controller.dart';
import 'package:sheshya/app/modules/teacher/home/controllers/teacher_home_controller.dart';
import 'package:sheshya/app/modules/teacher/journal/controllers/record_journal_controller.dart';
import 'package:sheshya/app/modules/teacher/classroom/controllers/teacher_classroom_controller.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';

import '../app/modules/parent/parent_home/parent_home_controller.dart';

class Di extends Bindings {
  @override
  void dependencies() {
    Get.put<TeacherProfileController>(TeacherProfileController());
    Get.put<SplashController>(SplashController());
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ManagementController>(ManagementController());
    Get.put<AiChatController>(AiChatController());
    Get.put<TeacherClassroomController>(TeacherClassroomController());
    Get.put<TeacherHomeController>(TeacherHomeController());
    Get.put<AttendanceController>(AttendanceController());
    Get.put<JournalController>(JournalController());

    Get.put<ParentHomeController>(ParentHomeController());
  }
}
