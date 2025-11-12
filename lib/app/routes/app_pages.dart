// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/classroom_select_screen.dart';

import '../modules/teacher/ai_chat/views/ai_chat_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/onboarding_view.dart';
import '../modules/auth/views/otp_verify_view.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/teacher/error/views/error_view.dart';
import '../modules/teacher/home/views/teacher_home_view.dart';
import '../modules/teacher/teacher_chatbox/views/teacher_chatbox_view.dart';
import '../modules/teacher/teacher_input/views/teacher_input_welcome_view.dart';
import '../modules/teacher/teacher_profile/views/teacher_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
    ),
    GetPage(
      name: _Paths.OTP_VERIFY,
      page: () => const OtpVerifyView(),
    ),
    GetPage(
      name: _Paths.TEACHER_HOME,
      page: () => const TeacherHomeView(),
    ),
    GetPage(
      name: _Paths.TEACHER_AI_CHAT,
      page: () => AiChatView(
        teacherImage: Get.arguments as String,
      ),
    ),
    GetPage(
      name: _Paths.TEACHER_PROFILE,
      page: () => const TeacherProfileView(),
    ),
    GetPage(
      name: _Paths.TEACHER_INPUT_WELCOME,
      page: () => const TeacherInputWelcomeView(),
    ),
    GetPage(
      name: _Paths.ERROR,
      page: () => ErrorView(),
    ),
    GetPage(
      name: _Paths.TEACHER_CHATBOX,
      page: () => const TeacherChatboxView(),
    ),
    GetPage(
      name: _Paths.TEACHER_CLASSROOM,
      page: () => const ClassroomSelectScreen(),
    ),
  ];
}
