// import 'dart:io';

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
import '../parent_home/parent_home_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'get_activity_res_model.dart';
import 'get_today_attendance_res_model.dart';


class ActivityController extends GetxController {
  ApiClient apiClient = ApiClient();


  GetTodayAttendanceResModel? getTodayAttendanceResModel;
  Rx<RxStatus> isGetTodayAttendanceLoading = RxStatus.loading().obs;


  GetActivityResModel? getActivityResModel;
  Rx<RxStatus> isActivityLoading = RxStatus.loading().obs;




  final ParentHomeController parentHomeController = Get.find();


  ActivityController();


  @override
  void onInit() {
    super.onInit();
    loadTodayAttendance();
    loadActivity();
  }


  void loadTodayAttendance() async {
    isGetTodayAttendanceLoading.value = RxStatus.loading();
    try {

      var res = await apiClient.get(
        '/student/getTodayAttendance',
        passToken: true,
      );

      if (res.statusCode == 200) {
        getTodayAttendanceResModel = GetTodayAttendanceResModel.fromJson(res.body);

        isGetTodayAttendanceLoading.value = RxStatus.success();
      }
      else {
        isGetTodayAttendanceLoading.value = RxStatus.success();
      }
    } catch (e)  {
      // showCustomSnackBar("Something went wrong!");
      isGetTodayAttendanceLoading.value = RxStatus.error();
    }
  }


  void loadActivity() async {
    isActivityLoading.value = RxStatus.loading();
    try {

      var res = await apiClient.get(
        '/student/fetchTodayActivity',
        passToken: true,
      );

      if (res.statusCode == 200) {
        getActivityResModel = GetActivityResModel.fromJson(res.body);

        isActivityLoading.value = RxStatus.success();
      } else if (res.statusCode == 400) {
        // showCustomSnackBar(res.body['message']);
        isActivityLoading.value = RxStatus.error();
      }
      else{
        // showCustomSnackBar("Something went wrong!");
        isActivityLoading.value = RxStatus.error();
      }
    } catch (e)  {
      // showCustomSnackBar("Something went wrong!");
      isActivityLoading.value = RxStatus.error();
    }
  }





  @override
  void onClose() {
    super.onClose();
  }

}
