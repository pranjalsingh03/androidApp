// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const LOGIN = _Paths.LOGIN;
  static const OTP_VERIFY = _Paths.OTP_VERIFY;

  // * Teacher
  static const TEACHER_HOME = _Paths.TEACHER_HOME;
  static const TEACHER_AI_CHAT = _Paths.TEACHER_AI_CHAT;
  static const TEACHER_PROFILE = _Paths.TEACHER_PROFILE;
  static const TEACHER_INPUT_WELCOME = _Paths.TEACHER_INPUT_WELCOME;
  static const ERROR = _Paths.ERROR;
  static const TEACHER_CHATBOX = _Paths.TEACHER_CHATBOX;
  static const TEACHER_CLASSROOM = _Paths.TEACHER_CLASSROOM;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/';
  static const ONBOARDING = '/onboarding';
  static const LOGIN = '/login';
  static const OTP_VERIFY = '/otp-verify';

  // * Teacher
  static const TEACHER_HOME = '/teacher-home';
  static const TEACHER_AI_CHAT = '/teacher-ai-chat';
  static const TEACHER_PROFILE = '/teacher-profile';
  static const TEACHER_INPUT_WELCOME = '/teacher-input-welcome';
  static const ERROR = '/error';
  static const TEACHER_CHATBOX = '/teacher-chatbox';
  static const TEACHER_CLASSROOM = '/teacher-classroom';
}
