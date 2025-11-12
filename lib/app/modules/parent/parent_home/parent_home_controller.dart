import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/data/const_data/fee_data.dart';
import 'package:sheshya/app/data/model/ui_models/dues_model.dart';
import 'package:sheshya/app/data/model/ui_models/fee_model.dart';
import 'package:sheshya/app/modules/auth/views/onboarding_view.dart';
import 'package:sheshya/app/modules/parent/parent_home/student_profile_res_model.dart';
import 'package:sheshya/helper/custom_print.dart';

import '../../../../components/custom_snackbar_widget.dart';
import '../../../../components/loader.dart';
import '../../../data/api/api_client.dart';
import '../../../data/api/api_constants.dart';
import '../../student/edit_profile/edit_profile_screen.dart';

class ParentHomeController extends GetxController with GetSingleTickerProviderStateMixin {
  final RxInt currentIndex = 0.obs;
  // final List fee = [];
  FeeModel? fee;
  ApiClient apiClient = ApiClient();
  var dues = <Due>[].obs;
  var pastPayments = <PastPayment>[].obs;
  var isLoading = false.obs;
  String? currentOrderId;
  int? currentAmount;
  String? currentMonth;

  StudentProfileResModel? studentProfileResModel;
  Rx<RxStatus> isStudentProfileLoading = RxStatus.loading().obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  DateTime? selectedDate;
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  TextEditingController dobController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController schoolName = TextEditingController();
  TextEditingController classController = TextEditingController();
  TextEditingController rollNumber= TextEditingController();
  TextEditingController monthlyFeePayable= TextEditingController();

  Rx<RxStatus> isStudentDetailsUpdating = RxStatus.loading().obs;

  ParentHomeController();

  late TabController tabController;

  RxInt currentDay = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    currentDay.value = getTodayIndex();
    loadStudentProfile();
    getFeesStatus();
    getAllDues();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void loadStudentProfile() async {
    isStudentProfileLoading.value = RxStatus.loading();
    studentProfileResModel = null;
    try {
      var res = await apiClient.get(ApiConstants.studentProfile, passToken: true, baseUrl: ApiConstants.apiBaseUrlNew);

      if (res.statusCode == 200) {
        customPrint("Student Profile Response: ${res.body}");
        studentProfileResModel = StudentProfileResModel.fromJson(res.body);
        customPrint("Student Profile Model: ${studentProfileResModel}");
        if ((studentProfileResModel?.data?.basic?.name == null) || (studentProfileResModel!.data!.basic!.name!.isEmpty)) {
          showCustomSnackBar("Submit details!");
          isStudentProfileLoading.value = RxStatus.error();

          await Get.to(EditProfileScreen());
          loadStudentProfile();
        } else {
          // Populate the controllers with the fetched data
          nameController.text = studentProfileResModel!.data!.basic!.name!;
          emailController.text = studentProfileResModel!.data!.basic!.email!;
          dobController.text = studentProfileResModel!.data!.basic!.dob!;
          fatherNameController.text = studentProfileResModel!.data!.basic!.fatherName!;
          motherNameController.text = studentProfileResModel!.data!.basic!.motherName!;
          phoneNumberController.text = studentProfileResModel!.data!.basic!.phoneNo!;
          genderController.text = studentProfileResModel!.data!.basic!.gender!;
          schoolName.text = studentProfileResModel!.data!.academic!.schoolName!;
          classController.text = studentProfileResModel!.data!.academic!.className!;
          rollNumber.text = studentProfileResModel!.data!.academic!.rollNum.toString();
          monthlyFeePayable.text = studentProfileResModel!.data!.academic!.monthlyFeePayable.toString();
          isStudentProfileLoading.value = RxStatus.success();
        }
      } else if (res.statusCode == 400) {
        // showCustomSnackBar(res.body['message']);
        isStudentProfileLoading.value = RxStatus.error();
      } else {
        Get.to(()=>OnboardingView());
        // showCustomSnackBar("Something went wrong!");
        isStudentProfileLoading.value = RxStatus.error();
      }
    } catch (e) {
      // showCustomSnackBar("Something went wrong!");
      isStudentProfileLoading.value = RxStatus.error();
    }
  }

  void updateStudentDetails() async {
    showCircularDialogLoader();
    isStudentDetailsUpdating.value = RxStatus.loading();
    try {
      var res = await apiClient.post(ApiConstants.studentDetailsUpdate,baseUrl: ApiConstants.apiBaseUrlNew, {
        "name": nameController.text,
        "email": emailController.text,
        "phoneNo": phoneNumberController.text,
        "gender": genderController.text,
        "dob": dobController.text,
        "fatherName": fatherNameController.text,
        "motherName": motherNameController.text
      }, passToken: true);

      if (res.statusCode == 200) {
        Get.back();
        loadStudentProfile();
        isStudentDetailsUpdating.value = RxStatus.success();
        Get.back();
        showCustomSnackBar("Updated Successfully", type: SnackBarType.success);
      } else if (res.statusCode == 400) {
        Get.back();
        showCustomSnackBar(res.body['message']);
        isStudentDetailsUpdating.value = RxStatus.error();
      } else {
        Get.back();
        showCustomSnackBar("Something went wrong!");
        isStudentDetailsUpdating.value = RxStatus.error();
      }
    } catch (e) {
      Get.back();
      showCustomSnackBar("Something went wrong!");
      isStudentDetailsUpdating.value = RxStatus.error();
    }
  }

  void changePageIndex(int index) {
    currentIndex.value = index;
  }

  // void toggleFee() {
  //   fee.value = fee.value == dueFee ? paidFee : dueFee;
  // }

  Future<void> getFeesStatus() async {
    try {
      var response = await apiClient.get("/finance/paymentDueNotification", passToken: true, baseUrl: ApiConstants.apiBaseUrlNew);
      if (response.statusCode == 200) {
        fee = FeeModel.fromMap(response.body);
      } else {
        // showCustomSnackBar("Failed to fetch fee status!");
      }
    } catch (e) {
      // showCustomSnackBar("An error occurred while fetching fee status!");
    }
  }

  Future<void> getAllDues() async {
    try {
      var response = await apiClient.get("/finance/fetchAllDues", passToken: true, baseUrl: ApiConstants.apiBaseUrlNew);
      if (response.statusCode == 200) {
        var data = DuesResponse.fromJson(response.body);
        dues.value = data.dueList;
        pastPayments.value = data.pastPayments;
      } else {
        // showCustomSnackBar("Failed to fetch fee status!");
      }
    } catch (e) {
      // showCustomSnackBar("An error occurred while fetching fee status!");
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> createOrder(int amount , String month) async {
    try {
      var response = await apiClient.post(
        "/finance/createRazorPayOrderId",
        {
          "amount": amount * 100, // Convert to paise
          "month": month,
        },
        passToken: true,
        baseUrl: "https://48b0-2402-e280-2146-16d-f4f3-ee8f-738c-5977.ngrok-free.app",
      );
      // debugPrint("Response: ${response.body}");
      customPrint("Response: ${response.body}");
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data["orderId"]; // Assuming backend returns `orderId`
      } else {
        // debugPrint("Failed to create order: ${response.body}");
        return "";
      }
    } catch (e) {
      // debugPrint("Error creating order: $e");
      return "";
    }
  }

  Future<void> updatePaymentStatus(String orderId,String paymentId ,int amount, String month,String status) async {
    try {
      var response = await apiClient.post(
        "/finance/verifyPayment",
        {
          "orderId": paymentId,
          "paymentId": paymentId,
          "amount": amount,
          "month": month,
          "status": "completed",
        },
        passToken: true,
        baseUrl: "https://48b0-2402-e280-2146-16d-f4f3-ee8f-738c-5977.ngrok-free.app",
      );
      if (response.statusCode == 200) {
        debugPrint("Payment updated successfully.");
      } else {
        debugPrint("Failed to update payment: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error updating payment: $e");
    }
  }

  int getTodayIndex() {
    // Get today's weekday (1 = Monday, 7 = Sunday)
    int currentWeekday = DateTime.now().weekday;

    // Adjust the index to match the daysOfWeek list (Monday = 0, Saturday = 5)
    // Since currentWeekday (1 = Monday, ..., 7 = Sunday), we subtract 1 to map it to the list index
    if (currentWeekday >= 1 && currentWeekday <= 6) {
      return currentWeekday - 1; // Returns index from 0 (Monday) to 5 (Saturday)
    } else {
      return -1;
    }
  }
}
