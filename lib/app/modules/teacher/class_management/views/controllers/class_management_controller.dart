import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/modules/teacher/class_management/models/all_students_model.dart';
import 'package:sheshya/app/modules/teacher/class_management/models/student_model.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/helper/custom_print.dart';

class ManagementController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // MARK: - Dependencies
  final ApiClient apiClient = ApiClient();

  // MARK: - Controllers
  late TabController tabController;
  final TextEditingController searchcontroller = TextEditingController();
  final TextEditingController parentMessageController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController competitionController = TextEditingController();
  final GlobalKey<FormState> achievementFormKey = GlobalKey<FormState>();

  // MARK: - Observable Properties
  RxString selectedCategory = 'Education'.obs;

  // MARK: - State Properties
  int selectedIndex = 1;
  String selectedClass = '';
  String selectedSection = '';
  String selectedSectionId = '';
  bool isFetchingStudentDetail = false;
  bool isFetchingStudents = false;

  // MARK: - Data Properties
  StudentData? selectedStudent;
  StudentModel? studentDetail;
  List<StudentData> students = [];

  // MARK: - Lifecycle Methods
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    searchcontroller.dispose();
    parentMessageController.dispose();
    positionController.dispose();
    competitionController.dispose();
    super.onClose();
  }

  // MARK: - Class and Section Management
  void updateSelectedClass(
      {required String className, required String sectionId, required String section}) {
    selectedClass = className;
    selectedSection = section;
    selectedSectionId = sectionId;
    update();
  }

  void changeIndex(int index) {
    if (index == 0) {
      selectedIndex = 1;
      Get.back();
    }
    update();
  }

  // MARK: - API Methods
  Future<void> fetchStudents(String sectionId) async {
    isFetchingStudents = true;
    update();
    try {
      final response = await apiClient.post(
        ApiConstants.getStudentsListbySection,
        baseUrl: ApiConstants.apiBaseUrlNew,
        {"assignmentId": "test", "sectionId": sectionId},
      );

      if (response.body['success']) {
        students = (response.body['data'] as List)
            .map((e) => StudentData.fromJson(e))
            .toList();
        isFetchingStudents = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          update();
        });
      } else if (response.body['success'] == false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showCustomSnackBar(ApiConstants.serverErrorMsg);
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showCustomSnackBar(response.body['message']);
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomSnackBar("Something went wrong!");
      });
    } finally {
      isFetchingStudents = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        update();
      });
    }
  }

  Future<void> fetchStudentDetail(String studentId) async {
    try {
      isFetchingStudentDetail = true;
      update();

      final response = await apiClient.post(
        ApiConstants.getStudentDetailById,
        baseUrl: ApiConstants.apiBaseUrlNew,
        {"studentId": studentId},
      );

      customPrint(response.body);

      if (response.body['success']) {
        studentDetail = StudentModel.fromJson(response.body["data"]);
        isFetchingStudentDetail = false;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          update();
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showCustomSnackBar(response.body['message']);
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomSnackBar("Something went wrong!");
      });
    } finally {
      isFetchingStudentDetail = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        update();
      });
    }
  }
}