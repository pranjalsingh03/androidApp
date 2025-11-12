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

import '../../../../components/loader.dart';
import '../../parent/parent_home/parent_home_screen.dart';

class ParentProfileController extends GetxController {
  ApiClient apiClient = ApiClient();

  final FocusNode feedbackFocusNode = FocusNode();
  final TextEditingController feedbackController = TextEditingController();
  RxBool isValidFeedback = false.obs;
  RxInt selectedRating = 4.obs;

  Rx<RxStatus> isFeedbackLoading = RxStatus.loading().obs;


  ParentProfileController();


  @override
  void onInit() {
    super.onInit();
  }


  void postFeedback(String stars, String content) async {
    showCircularDialogLoader();

    try {

      var res = await apiClient.post(ApiConstants.studentFeedback,baseUrl: ApiConstants.apiBaseUrlNew, {
        "stars" : stars,
        "content" : content
      }, passToken: true);

      if (res.statusCode == 200) {
        Get.back();
        Get.back();
        feedbackController.clear();
        showCustomSnackBar("Feedback Submitted", type: SnackBarType.success);
      } else if (res.statusCode == 400) {
        Get.back();
        showCustomSnackBar(res.body['message']);
      }
      else {
        Get.back();
        showCustomSnackBar("Something went wrong!");
      }
      // } catch (e) {
      //   showCustomSnackBar("VERIFY OTP FAILED");
      //   customPrint("❌ VERIFY OTP FAILED\n$e");
    } catch (e)  {
      Get.back();
      showCustomSnackBar("Something went wrong!");
    }
  }

}
