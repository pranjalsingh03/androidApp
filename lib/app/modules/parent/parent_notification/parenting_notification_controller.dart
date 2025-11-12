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
import 'get_notification_student_model.dart';

class ParentingNotificationController extends GetxController {
  ApiClient apiClient = ApiClient();

  GetNotificationStudentsResModel? getNotificationStudentsResModel;
  Rx<RxStatus> isNLoading = RxStatus.loading().obs;


  ParentingNotificationController();


  @override
  void onInit() {
    super.onInit();
    loadNotification();
  }


  void loadNotification() async {

    isNLoading.value = RxStatus.loading();
    try {

      var res = await apiClient.get(ApiConstants.getNotificationStudent,baseUrl: "https://sheshya-backend-deployed-529940359558.asia-south1.run.app", passToken: true);

      if (res.statusCode == 200) {
        getNotificationStudentsResModel = GetNotificationStudentsResModel.fromJson(res.body);

        isNLoading.value = RxStatus.success();
      } else if (res.statusCode == 400) {
        showCustomSnackBar(res.body['message']);
        isNLoading.value = RxStatus.error();
      }
      // } catch (e) {
      //   showCustomSnackBar("VERIFY OTP FAILED");
      //   customPrint("❌ VERIFY OTP FAILED\n$e");
    } catch (e)  {
      showCustomSnackBar("Something went wrong!");
      isNLoading.value = RxStatus.error();
    }
  }

}
