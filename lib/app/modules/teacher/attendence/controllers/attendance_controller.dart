import 'dart:math';

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/modules/teacher/class_management/models/all_students_model.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/helper/custom_print.dart';

class AttendanceController extends GetxController {
  final ApiClient apiClient = ApiClient();
  var selectedIndex = 1.obs;
  var isLoadingClass = false.obs;
  bool isFetchingStudents = false;
  bool isMarkingAttendance = false;
  var isFetchingLeaveData = false.obs;

  List<StudentData> students = [];

  var selectedDate = DateTime.now().obs;
  var selectedMonth = DateTime.now().month.obs;
  var selectedYear = DateTime.now().year.obs;
  final random = Random();

  var selectedClass = ''.obs;
  var selectedSection = ''.obs;

  final EasyInfiniteDateTimelineController calendarController =
      EasyInfiniteDateTimelineController();

  var presentDays = 0.obs;
  var absentDays = 0.obs;
  var leaveDays = 0.obs;
  var totalStudents = 0.obs;
  var presentCount = 0.obs;
  var absentCount = 0.obs;
  List<StudentData> presentStudents = [];
  List<StudentData> absentStudents = [];
  List<StudentData> leaveStudents = [];

  double get presentPercentage => presentDays.value / totalDays * 100;
  double get absentPercentage => absentDays.value / totalDays * 100;
  double get leavePercentage => leaveDays.value / totalDays * 100;

  int get totalDays => presentDays.value + absentDays.value + leaveDays.value;

  List<String> selectedStudents = [];

  @override
  void onInit() {
    super.onInit();
    fetchTeacherProfile(); // Fetch teacher profile on initialization
  }

  Future<void> fetchTeacherProfile() async {
    isLoadingClass.value = true;
    try {
      final response = await apiClient.get(
        ApiConstants.teacherProfile,
        baseUrl: ApiConstants.apiBaseUrlNew,
      );

      if (response.statusCode == 200) {
        var profile = response.body['data'];
        if (profile['classTeacher'] != null && profile['classTeacher'].isNotEmpty) {
          var classTeacher = profile['classTeacher'][0];
          selectedClass.value = classTeacher['classId']['className'];
          selectedSection.value = classTeacher['section'];
          fetchStudents(); // Fetch students for the assigned class and section
          fetchClassDetails(classTeacher['_id']);
        } else {
          // showCustomSnackBar("No class assigned to the teacher");
        }
      } else {
        // showCustomSnackBar(response.body['message'] ?? "Failed to load teacher profile");
      }
    } catch (e) {
      // showCustomSnackBar("Something went wrong");
    } finally {
      isLoadingClass.value = false;
    }
  }

  void fetchStudents() async {
    isFetchingStudents = true;
    update();
    try {
      final response = await apiClient.get(
        ApiConstants.getClassStudents,
        baseUrl: ApiConstants.apiBaseUrlNew,
      );

      if (response.statusCode == 200) {
        students = AllStudentsModel.fromJson(response.body).data;
        debugPrint("Fetched ${students} students");
        isFetchingStudents = false;
        update();
      } else if (response.statusCode! >= 500) {
        showCustomSnackBar(ApiConstants.serverErrorMsg);
      } else {
        showCustomSnackBar(response.body['message']);
      }
    } catch (e) {
      debugPrint("FETCH STUDENTS FAILED\n$e");
      showCustomSnackBar("Something went wrong");
    } finally {
      isFetchingStudents = false;
      update();
    }
  }

  Future<void> fetchClassDetails(String sclassId) async {
    isLoadingClass.value = true;
    try {
      final response = await apiClient.post(
        ApiConstants.getClassDetails,
        baseUrl: ApiConstants.apiBaseUrlNew,
        {
          "sclassId": sclassId,
          "date": DateTime.now().toIso8601String().split('T')[0],
        },
      );

      if (response.statusCode == 200) {
        var data = response.body;
        selectedClass.value = data['className'];
        selectedSection.value = data['section'];
        totalStudents.value = data['totalStudents'];
        presentCount.value = data['presentCount'];
        absentCount.value = data['absentCount'];
        presentStudents = (data['presentStudents'] as List)
            .map((e) => StudentData.fromJson(e))
            .toList();
        absentStudents = (data['absentStudents'] as List)
            .map((e) => StudentData.fromJson(e))
            .toList();
        update();
        customPrint(response.body);
      } else {
        showCustomSnackBar(response.body['message'] ?? "Failed to load class details");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong");
    } finally {
      isLoadingClass.value = false;
    }
  }

  Future<void> fetchStudentAttendance(String studentId, String month) async {
    try {
      final response = await apiClient.post(
        ApiConstants.getStudentAttendance,
        baseUrl: ApiConstants.apiBaseUrlNew,
        {
          "studentId": studentId,
          "month": month,
        },
      );

      if (response.body['success']) {
        var data = response.body['data'];
        presentDays.value = data['present'];
        absentDays.value = data['absent'];
        leaveDays.value = data['leave'];
        update();
      } else {
        showCustomSnackBar(response.body['message'] ?? "Failed to load student attendance");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong");
    }
  }

  void toggleSelection(String studentId) {
    if (selectedStudents.contains(studentId)) {
      selectedStudents.remove(studentId);
    } else {
      selectedStudents.add(studentId);
    }
    update();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void updateSelectedClass(String classes) {
    selectedClass.value = classes;
  }

  void updateSelectedSection(String section) {
    selectedSection.value = section;
  }

  void incrementMonth() {
    if (selectedMonth.value == 12) {
      selectedMonth.value = 1;
      selectedYear.value++;
    } else {
      selectedMonth.value++;
    }
  }

  void decrementMonth() {
    if (selectedMonth.value == 1) {
      selectedMonth.value = 12;
      selectedYear.value--;
    } else {
      selectedMonth.value--;
    }
  }

  void selectMonthYear(int month, int year) {
    selectedMonth.value = month;
    selectedYear.value = year;
  }

  //for botomnavbar section
  void changeIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  Future<bool> markAttendance() async {
    try {
      isMarkingAttendance = true;
      update();
      final body = {
        "presentStudentIds": selectedStudents.toList()
      };

      final res = await apiClient.post(ApiConstants.markAttendance, baseUrl: ApiConstants.apiBaseUrlNew, body);

      if (res.statusCode == 200) {
        return true;
      } else {
        showCustomSnackBar(res.body['message'] ?? "Something went wrong!");
      }
      return false;
    } catch (e) {
      showCustomSnackBar("Something went wrong!");
      debugPrint(e.toString());
      return false;
    } finally {
      isMarkingAttendance = false;
      update();
    }
  }
    Future<void> fetchLeaveDataByDate(String date) async {
    isFetchingLeaveData.value = true;
    update();
    try {
      final response = await apiClient.post(
        ApiConstants.getLeaveByDateAndSclass,
        baseUrl: ApiConstants.apiBaseUrlNew,
        {
          "date": date,
        },
      );

      if (response.statusCode == 200) {
        leaveStudents = (response.body['data'] as List)
            .map((e) => StudentData.fromJson(e))
            .toList();
        update();
        customPrint(response.body);
      } else {
        showCustomSnackBar(response.body['message'] ?? "Failed to load leave data");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong");
    } finally {
      isFetchingLeaveData.value = false;
      update();
    }
  }
}