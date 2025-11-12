import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/model/response/otp_verify_model.dart';

class AuthRepo {
  ApiClient apiClient = ApiClient();

  // Future<(bool success, String message)> teachersendPhoneOtp(
  //     {required String phone, bool isTeacher = true}) async {
  //   final res = await apiClient.post(
  //       isTeacher ? ApiConstants.sendOtpTeacher : ApiConstants.sendParentMobileOtp,
  //       {
  //         'phone': phone,
  //       },
  //       passToken: false);

  //   if (res.statusCode! >= 500) {
  //     return (false, ApiConstants.serverErrorMsg);
  //   } else {
  //     return (res.body["success"] as bool, res.body['message'] as String);
  //   }
  // }

  Future<(bool success, String message)> sendOtpTeacher(
      {required bool toPhoneNo,required bool toEmail,required String phoneNo,required String email}) async {
    final res = await apiClient.post(
      baseUrl: ApiConstants.apiBaseUrlNew,
      ApiConstants.sendOtpTeacher,
        {
          'toPhoneNo':toPhoneNo,
          'phoneNo':phoneNo,
          'toEmail': toEmail,
          'email': email,
        },
        passToken: false);

    if (res.statusCode == 200) {
      return (true, res.body['message'] as String);
    } else {
      return (false, ApiConstants.serverErrorMsg);
    }
  }

  Future<(bool success, OtpVerifyModel? data, String message)>
      teacherVerifyPhoneOtp(
          {required String phone, required String otp}) async {
    final res = await apiClient.post(
        baseUrl: ApiConstants.apiBaseUrlNew,
        ApiConstants.verifyOtpTeacher, {'phone': phone, 'otp': otp},
        passToken: false);

    if (res.statusCode! >= 500) {
      return (false, null, ApiConstants.serverErrorMsg);
    } else {
      return (
        res.body["success"] as bool,
        OtpVerifyModel.fromJson(res.body['data']),
        res.body['message'] as String
      );
    }
  }

  Future<(bool success, String message)> sendOtpParent({required bool toPhoneNo,required bool toEmail,required String phoneNo,required String email}) async {
    final res = await apiClient.post(ApiConstants.parentSendOtpNew,
        {
          'toPhoneNo': toPhoneNo,
          'toEmail':toEmail,
          'phoneNo':phoneNo,
          'email':email
        },
        baseUrl: ApiConstants.apiBaseUrlNew,
        passToken: false);

    if (res.statusCode! >= 500) {
      return (false, ApiConstants.serverErrorMsg);
    } else {
      return (true, res.body['message'] as String);
    }
  }
}
