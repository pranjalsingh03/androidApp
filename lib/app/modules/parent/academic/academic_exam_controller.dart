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

import 'models/get_academic_performance_res_model.dart';
import 'models/get_exams_res_model.dart';
import 'models/get_subjects_res_model.dart';


class AcademicExamController extends GetxController {
  ApiClient apiClient = ApiClient();


  GetExamsResModel? getExamsResModel;
  Rx<RxStatus> isGetExamsLoading = RxStatus.loading().obs;
  RxString selectedExamId = ''.obs;


  GetSubjectsResModel? getSubjectsResModel;
  Rx<RxStatus> isGetSubjectsLoading = RxStatus.loading().obs;
  RxString selectedSubjectId = ''.obs;
  RxString selectedSubjectName = ''.obs;



  GetAcademicPerformanceModel? getAcademicPerformanceModel;
  Rx<RxStatus> isGetAcademicPerformanceLoading = RxStatus.loading().obs;



  final ParentHomeController parentHomeController = Get.find();


  AcademicExamController();


  @override
  void onInit() {
    super.onInit();
    loadExams();
  }


  void loadExams() async {
    isGetExamsLoading.value = RxStatus.loading();
    try {

      var res = await apiClient.get(
        '/students/exams',
        passToken: true,
      );

      if (res.statusCode == 200) {
        getExamsResModel = GetExamsResModel.fromJson(res.body);

        isGetExamsLoading.value = RxStatus.success();
      } else if (res.statusCode == 400) {
        // showCustomSnackBar(res.body['message']);
        isGetExamsLoading.value = RxStatus.error();
      }
      else{
        // showCustomSnackBar("Something went wrong!");
        isGetExamsLoading.value = RxStatus.error();
      }
    } catch (e)  {
      // showCustomSnackBar("Something went wrong!");
      isGetExamsLoading.value = RxStatus.error();
    }
  }


  void loadSubjects() async {
    isGetSubjectsLoading.value = RxStatus.loading();
    try {

      var res = await apiClient.get(
        '/students/exam/subjects/${selectedExamId.value}',
        passToken: true,
      );

      if (res.statusCode == 200) {
        getSubjectsResModel = GetSubjectsResModel.fromJson(res.body);

        isGetSubjectsLoading.value = RxStatus.success();
      } else if (res.statusCode == 400) {
        showCustomSnackBar(res.body['message']);
        isGetSubjectsLoading.value = RxStatus.error();
      }
      else{
        showCustomSnackBar("Something went wrong!");
        isGetSubjectsLoading.value = RxStatus.error();
      }
    } catch (e)  {
      showCustomSnackBar("Something went wrong!");
      isGetSubjectsLoading.value = RxStatus.error();
    }
  }


  void loadAcademicPerformance() async {
    isGetAcademicPerformanceLoading.value = RxStatus.loading();
    try {

      var res = await apiClient.get(
        '/students/academic-performance/${selectedExamId.value}/${selectedSubjectId.value}',
        passToken: true,
      );

      if (res.statusCode == 200) {
        getAcademicPerformanceModel = GetAcademicPerformanceModel.fromJson(res.body);

        isGetAcademicPerformanceLoading.value = RxStatus.success();
      } else if (res.statusCode == 400) {
        showCustomSnackBar(res.body['message']);
        isGetAcademicPerformanceLoading.value = RxStatus.error();
      }
      else{
        showCustomSnackBar("Something went wrong!");
        isGetAcademicPerformanceLoading.value = RxStatus.error();
      }
    } catch (e)  {
      showCustomSnackBar("Something went wrong!");
      isGetAcademicPerformanceLoading.value = RxStatus.error();
    }
  }




  @override
  void onClose() {
    super.onClose();
  }

}
