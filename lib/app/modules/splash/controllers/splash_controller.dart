import 'package:get/get.dart';
import 'package:sheshya/app/data/model/user_type.dart';
import 'package:sheshya/app/data/respository/teacher/teacher_profile_repo.dart';
import 'package:sheshya/app/modules/auth/views/onboarding_view.dart';
import 'package:sheshya/app/modules/error/error_screen.dart';
import 'package:sheshya/app/modules/parent/parent_home/parent_home_controller.dart';
import 'package:sheshya/app/modules/teacher/home/views/teacher_home_view.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/app/routes/app_pages.dart';
import 'package:sheshya/constants/app_constants.dart';
import 'package:sheshya/helper/custom_print.dart';
import 'package:sheshya/helper/prefs_service.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';

import '../../parent/parent_home/parent_home_screen.dart';

class SplashController extends GetxController {


  Future<void> checkLoginStatus() async {
    try {
      final token = PrefsService.getToken();

      if (token == null) {
        await Get.offAll(() => const OnboardingView());
        return;
      }

      final userType = PrefsService.getUserType();

      if (userType == null) {
        await Get.offAll(() => const OnboardingView());
        return;
      }

      if ((userType == 'teacher') || (userType == UserType.teacher)) {
          final TeacherProfileController teacherProfileController =
      Get.put(TeacherProfileController());
        final res = await TeacherProfileRepository.getTeacherProfile();
        customPrint(res.toString());

        // if (!res.$1) {
        //   await Get.offAll(() => const ErrorScreen());
        //   return;
        // }

        final teacher = res.$2;

        if (teacher == null) {
          await Get.offAllNamed(Routes.ONBOARDING);
          return;
        }

        teacherProfileController.setTeacherProfile(
          teacherProfileModel: teacher,
        );

        await Get.offAll(
          () => const TeacherHomeView(),
        );
      } else {
        // final ParentHomeController controller = Get.find();
        // final studentProfile = await controller.loadStudentProfile;
        // customPrint(studentProfile.toString());
        // if (studentProfile == null) {
        //   await Get.offAll(() => const OnboardingView());
        //   return;
        // }

        await Get.offAll(
          () => ParentHomeScreen(),
        );
      }
    } catch (e) {
      customPrint(e.toString());
      Get.offAll(() => const OnboardingView());
      }
  }
}