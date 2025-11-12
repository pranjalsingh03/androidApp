import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/modules/parent/leave_attendance/filtered_attendance_analysis_res_model.dart';
import 'package:sheshya/app/modules/parent/leave_attendance/get_leaves_records_res_model.dart';
import 'package:sheshya/app/modules/parent/leave_attendance/leave_records_screen.dart';
import 'package:sheshya/app/modules/parent/leave_attendance/overall_attendance_analysis_res_model.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/helper/custom_print.dart';

class LeaveAttendanceController extends GetxController {
  ApiClient apiClient = ApiClient();

  Rx<RxStatus> isNLoading = RxStatus.loading().obs;
  RxString selectedMonth = ''.obs;
  Map<String, List<Map<String, dynamic>>> monthsWithDays = {};
  RxList<String> monthsName = [''].obs;
  RxList<DateTime> selectedDatesForLeave = <DateTime>[].obs;

  TextEditingController reasonForLeaveTextController = TextEditingController();

  OverallAttendanceAnalysisResModel? overallAttendanceAnalysisResModel;
  Rx<RxStatus> isOverallAttendanceAnalysisLoading = RxStatus.loading().obs;

  Rx<RxStatus> isFilteredAttendanceAnalysisLoading = RxStatus.loading().obs;
  RxList<Map<String, String>> daysInAMonthList = [{'':''}].obs;

  RxInt selectedYear = DateTime.now().year.obs; // Current year by default
  RxInt selectedMonthForAttendance = 1.obs; // Selected month
  RxInt currentIndex = 1.obs;

  List<int> years = [
    DateTime.now().year - 1,
    DateTime.now().year,
    DateTime.now().year + 1
  ];

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  LeaveAttendanceController();

  @override
  void onInit() {
    super.onInit();
    daysInAMonthList.clear();
    monthsName.clear();
    initializeMonths();
    selectedMonth.value = monthsWithDays.keys.first;
    selectedMonthForAttendance.value = DateTime.now().month;
    loadOverallAttendanceAnalysis();
    
  }

  void loadOverallAttendanceAnalysis() async {
    isOverallAttendanceAnalysisLoading.value = RxStatus.loading();
    try {
      var res = await apiClient.post(ApiConstants.studentGetAttendanceOverview,baseUrl: ApiConstants.apiBaseUrlNew,{
        "month":selectedMonthForAttendance.value,
        "year":selectedYear.value,
      }, passToken: true);
      customPrint("Response: ${res.body}");

      if (res.isOk) {
        overallAttendanceAnalysisResModel = OverallAttendanceAnalysisResModel.fromJson(res.body);
        isFilteredAttendanceAnalysisLoading.value = RxStatus.success();
        isOverallAttendanceAnalysisLoading.value = RxStatus.success();
        // loadFilteredAttendanceAnalysis();
      }
      else{
        showCustomSnackBar("Something went wrong!");
        isOverallAttendanceAnalysisLoading.value = RxStatus.error();
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong!");
      isOverallAttendanceAnalysisLoading.value = RxStatus.error();
    }
  }

  void loadFilteredAttendanceAnalysis() async {
    isFilteredAttendanceAnalysisLoading.value = RxStatus.loading();
    getDaysInMonth(selectedYear.value, selectedMonthForAttendance.value);
    try {
      var res = await apiClient.post(ApiConstants.studentGetAttendanceOverview,baseUrl: ApiConstants.apiBaseUrlNew, {
        "month": selectedMonthForAttendance.value,
        "year": selectedYear.value,
      }, passToken: true);

      if (res.statusCode == 200) {
        overallAttendanceAnalysisResModel = OverallAttendanceAnalysisResModel.fromJson(res.body);
        isFilteredAttendanceAnalysisLoading.value = RxStatus.success();
      } else if (res.statusCode == 400) {
        showCustomSnackBar(res.body['message']);
        isFilteredAttendanceAnalysisLoading.value = RxStatus.error();
      } else {
        showCustomSnackBar("Something went wrong!");
        isFilteredAttendanceAnalysisLoading.value = RxStatus.error();
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong!");
      isFilteredAttendanceAnalysisLoading.value = RxStatus.error();
    }
  }

  void getDaysInMonth(int year, int month) {
    int totalDays = DateTime(year, month + 1, 0).day;
    List<Map<String, String>> daysList = List.generate(totalDays, (index) {
      DateTime currentDate = DateTime(year, month, index + 1);
      return {
        "date": currentDate.day.toString(),
        "day": DateFormat('EEE').format(currentDate),
      };
    });
    daysInAMonthList.value = daysList;
  }

  void initializeMonths() {
    final now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime month = DateTime(now.year, now.month + i, 1);
      String monthName = DateFormat('MMMM').format(month);
      int daysInMonth = DateTime(month.year, month.month + 1, 0).day;

      monthsName.add(monthName);
      monthsWithDays[monthName] = List.generate(daysInMonth, (index) {
        DateTime currentDate = DateTime(month.year, month.month, index + 1);
        return {
          "date": index + 1,
          "day": DateFormat('EEE').format(currentDate),
          "formattedDate": DateFormat('yyyy-MM-dd').format(currentDate),
        };
      });
    }
  }

  void updateSelectedDatesForLeave(List<DateTime> dates) {
    selectedDatesForLeave.value = dates;
  }

  void onClickingApplyForLeave() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (reasonForLeaveTextController.text.isEmpty) {
      showCustomSnackBar("Please provide a reason for leave.");
      return;
    }
    if (selectedDatesForLeave.isEmpty) {
      showCustomSnackBar("Please select dates for leave.");
      return;
    }

    Loader(text:"Applying for Leave");

    List<String> formattedDates = selectedDatesForLeave.map((date) => date.toIso8601String().split('T')[0]).toList();

    Map<String, dynamic> requestMap = {
      "reason": reasonForLeaveTextController.text,
      "dates": formattedDates,
    };

    customPrint("Request Payload: $requestMap");

    try {
      var res = await apiClient.post(
        ApiConstants.studentApplyLeave,
        baseUrl: ApiConstants.apiBaseUrlNew,
        requestMap,
        passToken: true,
      );

      customPrint("Response: ${res.body}");

      if (res.statusCode == 200) {
        Get.back();
        Get.back();
        showCustomSnackBar("Applied for leave", type: SnackBarType.success);
      } else if (res.statusCode == 400) {
        Get.back();
        showCustomSnackBar(res.body['message']);
      } else {
        Get.back();
        showCustomSnackBar("Something went wrong!");
      }
    } catch (e) {
      Get.back();
      showCustomSnackBar("Something went wrong!");
      customPrint("Error: $e");
    }
  }

  void onClickingViewLeaveRecords(BuildContext context) async {
    // showCircularDialogLoader();
    try {
      var res = await apiClient.get(ApiConstants.studentGetLeaves, passToken: true);

      if (res.isOk) {
        GetLeavesRecordResModel getLeavesRecordResModel = GetLeavesRecordResModel.fromJson(res.body);
        Get.to(()=>LeaveAttendanceRecordsScreen(data: getLeavesRecordResModel.data));
      } else {
        Get.back();
        showCustomSnackBar("Something went wrong!");
      }
    } catch (e) {
      Get.back();
      showCustomSnackBar("Something went wrong!");
    }
  }


String formatDateToDDMMYYYY(String isoDate) {
  if (isoDate.isEmpty) return '';
  DateTime dateTime = DateTime.parse(isoDate);
  return DateFormat('dd-MM-yyyy').format(dateTime);
}

  String formatToIsoDate(int year, int month, int day) {
    DateTime dateTime = DateTime.utc(year, month, day);
    return dateTime.toIso8601String();
  }
}