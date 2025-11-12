import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/model/teacher/response/teacher_profile_model.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/models/leaves_res_model.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';

class TeacherProfileController extends GetxController {
  ApiClient apiClient = ApiClient();

  TeacherProfileModel? teacherProfileModel;
  LeavesResponse? leavesResponse;
  String displayName = "";
  DateTime selectedDate = DateTime.now();
  bool isTodaysAttendanceGiven = false;
  bool isTeacherOnLocation = false;
  // Loading states
  bool isCheckingLocation = false;
  bool isMarkingAttendance = false;
  bool isSubmittingFeedback = false;
  bool isGettingLeaves = false;

  // Leave application states
  RxString selectedMonth = ''.obs;
  RxList<String> monthsName = <String>[].obs;
  RxMap<String, List<Map<String, String>>> monthsWithDays = <String, List<Map<String, String>>>{}.obs;
  RxList<DateTime> selectedDatesForLeave = <DateTime>[].obs;
  TextEditingController reasonForLeaveTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializeMonths();
  }

  void initializeMonths() {
    final now = DateTime.now();
    final formatter = DateFormat('MMMM');
    for (int i = 0; i < 12; i++) {
      final month = DateTime(now.year, now.month + i, 1);
      monthsName.add(formatter.format(month));
      monthsWithDays[formatter.format(month)] = List.generate(
        DateTime(month.year, month.month + 1, 0).day,
        (index) => {
          'day': DateFormat('EEE').format(DateTime(month.year, month.month, index + 1)),
          'date': (index + 1).toString(),
          'formattedDate': DateFormat('yyyy-MM-dd').format(DateTime(month.year, month.month, index + 1)),
        },
      );
    }
    selectedMonth.value = monthsName.first;
  }

  void reset() {
    selectedDate = DateTime.now();
    update();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    update();
  }

  void setTeacherProfile({
    required TeacherProfileModel teacherProfileModel,
  }) {
    this.teacherProfileModel = teacherProfileModel;
    List<String> splittedNames = teacherProfileModel.name.split(" ");

    displayName = splittedNames.length == 1 || splittedNames[0].length >= 3
        ? splittedNames[0]
        : splittedNames[1];
    update();
  }

  Future<void> getTeacherTodaysAttendance() async {
    try {
      isTodaysAttendanceGiven =
          await getTeacherAttendance(date: DateTime.now());
    } catch (e) {
      isTodaysAttendanceGiven = false;
    } finally {
      update();
    }
  }

  Future<bool> getTeacherAttendance({required DateTime date}) async {
    try {
      final res = await apiClient.get(ApiConstants.teacherGetAttendance,);

      if (res.statusCode == 200) {
        return res.body["success"];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> checkTeacherLocation({
    required double latitude,
    required double longitude,
  }) async {
    isCheckingLocation = true;
    update();
    try {
      final res = await apiClient.post(ApiConstants.teacherCheckLocation,baseUrl: ApiConstants.apiBaseUrlNew, {
        "destlat": latitude,
        "destlong": longitude,
      });
      if (res.isOk) {
        isTeacherOnLocation = res.body["success"];
        if (isTeacherOnLocation) {
          showCustomSnackBar("Attendance marked successfully", type: SnackBarType.success);
          isTodaysAttendanceGiven = true;
        } else {
          showCustomSnackBar("You are not on location", type: SnackBarType.error);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      showCustomSnackBar("Error checking location", type: SnackBarType.error);
    } finally {
      isCheckingLocation = false;
      update();
    }
  }

  Future<void> getTeacherAllLeaves() async {
    isGettingLeaves = true;
    update();
    try {
      final res = await apiClient.get(ApiConstants.teacherGetLeaves);
      if (res.isOk) {
        leavesResponse = LeavesResponse.fromJson(res.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGettingLeaves = false;
      update();
    }
  }

  Future<void> onClickingApplyForLeave() async {
    try {
      final res = await apiClient.post(
        '/teacher/applyLeave',
        {
          "dates": selectedDatesForLeave.map((date) => date.toIso8601String()).toList(),
          "reason": reasonForLeaveTextController.text,
        },
        baseUrl: ApiConstants.apiBaseUrlNew,
      );

      if (res.statusCode == 200) {
        showCustomSnackBar(
          res.body["message"] ?? "Leave applied successfully",
          type: SnackBarType.success,
          duration: const Duration(seconds: 2),
        );
        selectedDatesForLeave.clear();
        reasonForLeaveTextController.clear();
      } else {
        showCustomSnackBar("Failed to apply for leave");
      }
    } catch (e) {
      showCustomSnackBar("Error applying for leave");
    }
  }

  Future<bool> submitTeacherFeedback({
    required String stars,
    required String content,
  }) async {
    isSubmittingFeedback = true;
    update();
    try {
      final res = await apiClient.post(
        ApiConstants.teacherFeedback,
        {
          "stars": stars,
          "content": content,
        },
      );

      if (res.statusCode == 200) {
        isSubmittingFeedback = false;
        update();
        showCustomSnackBar(
          res.body["message"] ?? "Feedback submitted successfully",
          type: SnackBarType.success,
          duration: const Duration(seconds: 2),
        );
        return true;
      } else {
        showCustomSnackBar("Failed to submit feedback");
        return false;
      }
    } catch (e) {
      showCustomSnackBar("Error submitting feedback");
      return false;
    } finally {
      isSubmittingFeedback = false;
      update();
    }
  }
}