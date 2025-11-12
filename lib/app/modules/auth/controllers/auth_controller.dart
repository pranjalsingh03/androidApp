import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/model/login_type.dart';
import 'package:sheshya/app/data/model/user_type.dart';
import 'package:sheshya/app/data/respository/auth_repo.dart';
import 'package:sheshya/app/data/respository/teacher/teacher_profile_repo.dart';
import 'package:sheshya/app/modules/auth/views/otp_verify_view.dart';
import 'package:sheshya/app/modules/teacher/error/views/error_view.dart';
import 'package:sheshya/app/modules/teacher/home/views/teacher_home_view.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/constants/pref_constants.dart';
import 'package:sheshya/helper/custom_print.dart';

import '../../parent/parent_home/parent_home_screen.dart';
import '../model/parent_login_verify_model.dart';

class AuthController extends GetxController {
  final box = GetStorage();
  ApiClient apiClient = ApiClient();
  final TeacherProfileController teacherProfileController =
      Get.find<TeacherProfileController>();

  ParentLoginVerifyResModel? parentLoginVerifyResModel;

  UserType _userType = UserType.parent;
  UserType get userType => _userType;

  LoginType _loginType = LoginType.phone;
  LoginType get loginType => _loginType;

  String countryCode = "+91";
  String phoneNumber = "";
  String email = "";

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void toggleLoginType() {
    _loginType =
        _loginType == LoginType.phone ? LoginType.email : LoginType.phone;
    phoneNumberController.clear();
    emailController.clear();
    otpController.clear();
    update();
  }

  void setUserType(UserType type) {
    _userType = type;
    update();
  }

  bool _isPhoneNumberValid = false;
  bool get isPhoneNumberValid => _isPhoneNumberValid;

  bool _isEmailValid = false;
  bool get isEmailValid => _isEmailValid;

  bool _isOtpValid = false;
  bool get isOtpValid => _isOtpValid;

  bool _isSendingOtp = false;
  bool get isSendingOtp => _isSendingOtp;

  bool _isVerifyingOtp = false;
  bool get isVerifyingOtp => _isVerifyingOtp;

  void validatePhoneNumber(String value) {
    _isPhoneNumberValid =
        value.length == 10 && RegExp(r'^[0-9]{10}$').hasMatch(value);
    update();
  }

  void validateEmail(String value) {
    _isEmailValid = value.isEmail;
    update();
  }

  void validateOtp(String value) {
    _isOtpValid = value.length == 6 && RegExp(r'^[0-9]{6}$').hasMatch(value);
    update();
  }

  Future<void> sendOtp() async {
  phoneNumber = countryCode + phoneNumberController.text.trim();
  email = emailController.text.trim();
  _isSendingOtp = true;
  update();

  try {
    if (userType == UserType.teacher) {
      var res = await AuthRepo().sendOtpTeacher(
        toPhoneNo: loginType == LoginType.phone,
        toEmail: loginType == LoginType.email,
        phoneNo: (loginType == LoginType.phone) ? phoneNumber : "",
        email: email,
      );

      if (res.$1) {
        showCustomSnackBar(res.$2, type: SnackBarType.success);
        Get.to(() => const OtpVerifyView());
      } else {
        showCustomSnackBar(res.$2, type: SnackBarType.error);
      }
    } else {
      var res = await AuthRepo().sendOtpParent(
        toPhoneNo: loginType == LoginType.phone,
        toEmail: loginType == LoginType.email,
        phoneNo: (loginType == LoginType.phone) ? phoneNumber : "",
        email: email,
      );

      if (res.$1) {
        showCustomSnackBar(res.$2, type: SnackBarType.success);
        Get.to(() => const OtpVerifyView());
      } else {
        showCustomSnackBar(res.$2, type: SnackBarType.error);
      }
    }
  } catch (e) {
    showCustomSnackBar("An error occurred: $e", type: SnackBarType.error);
  } finally {
    _isSendingOtp = false;
    update();
  }
}


void verifyOtp() async {
  if (!_isOtpValid) return;
  _isVerifyingOtp = true;
  update();

  try {
    String verifyOtpEndPoint = "";
    Map<String, String> reqBody = {};
    if (UserType.parent == userType) {
      verifyOtpEndPoint = ApiConstants.parentVerifyOtpNew;
      phoneNumber = countryCode + phoneNumberController.text.trim();
      reqBody = {
        'email': email,
        'phone': (loginType == LoginType.phone) ? phoneNumber : "",
        'otp': otpController.text.trim()
      };
      var otpRes = await apiClient.post(verifyOtpEndPoint, reqBody, baseUrl: ApiConstants.apiBaseUrlNew, passToken: false);
      if (otpRes.statusCode == 200) {
        var data = otpRes.body['data'];
        showCustomSnackBar("OTP Verified Successfully", type: SnackBarType.success);
        await saveTokenAndUserType(otpRes.body['accessToken'], userType);
        parentLoginVerifyResModel = ParentLoginVerifyResModel.fromJson(otpRes.body);
        box.write(PrefConstants.studentId, parentLoginVerifyResModel?.data?.student?.sId);
        Get.offAll(() => ParentHomeScreen());
        resetAll();
      } else if (otpRes.statusCode == 400) {
        showCustomSnackBar(otpRes.body['message']);
      }
    } else {
      if (userType == UserType.teacher && loginType == LoginType.phone) {
        verifyOtpEndPoint = ApiConstants.verifyOtpTeacher;
      } else if (userType == UserType.teacher && loginType == LoginType.email) {
        verifyOtpEndPoint = ApiConstants.verifyOtpTeacher;
      }

      if (loginType == LoginType.phone) {
        reqBody = {
          'email':'',
          'phone': phoneNumber,
          'otp': otpController.text.trim(),
        };
      } else {
        reqBody = {
          'phone': '',
          'email': email,
          'otp': otpController.text.trim(),
        };
      }

      var otpRes = await apiClient.post(verifyOtpEndPoint, reqBody, passToken: false, baseUrl: ApiConstants.apiBaseUrlNew);
      if (otpRes.statusCode == 200) {
        var data = otpRes.body['data'];

        showCustomSnackBar("OTP Verified Successfully", type: SnackBarType.success);
        await saveTokenAndUserType(otpRes.body['accessToken'], userType);
        customPrint("user type $UserType");

        if (userType == UserType.teacher) {
          final res = await TeacherProfileRepository.getTeacherProfile();
          customPrint("response from teacher profile$res");
          if (res.$1 == true) {
            final teacher = res.$2;
            customPrint("👨‍🏫 TEACHER PROFILE: $teacher");

            if (teacher != null) {
              teacherProfileController.setTeacherProfile(
                teacherProfileModel: teacher,
              );
              Get.offAll(() => const TeacherHomeView());
            } else {
              Get.offAll(() => const ErrorView( ));
            }
          } else {
            showCustomSnackBar("Failed to fetch teacher profile", type: SnackBarType.error);
          }
        } else {
          parentLoginVerifyResModel = ParentLoginVerifyResModel.fromJson(otpRes.body);
          box.write(PrefConstants.studentId, parentLoginVerifyResModel?.data?.student?.sId);
          Get.offAll(() => ParentHomeScreen());
        }

        resetAll();
      } else if (otpRes.statusCode == 400) {
        showCustomSnackBar(otpRes.body['message']);
      }
    }
  } catch (e) {
    showCustomSnackBar("An error occurred: $e", type: SnackBarType.error);
  } finally {
    _isVerifyingOtp = false;
    update();
  }
}

  void resetAll() {
    phoneNumberController.clear();
    emailController.clear();
    otpController.clear();
    update();
  }

  Future<bool> saveTokenAndUserType(String token, UserType userType) async {
    try {
      await box.write(PrefConstants.token, token);
      await box.write(PrefConstants.userType, userType.name);
    } catch (e) {
      customPrint("❌ Error Saving Token & User Type\n$e");
      return false;
    }
    customPrint("✅ Token Saved to Device");
    customPrint("✅ TOKEN: ${box.read(PrefConstants.token)}");
    customPrint("✅ USER TYPE: ${box.read(PrefConstants.userType)}");
    return true;
  }
}
