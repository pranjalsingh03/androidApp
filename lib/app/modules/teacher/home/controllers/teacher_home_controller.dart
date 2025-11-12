import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/model/teacher/response/teacher_profile_model.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/app/data/model/teacher/response/current_class_model.dart';

class TeacherHomeController extends GetxController {
  final ApiClient apiClient = ApiClient();

  TeacherProfileModel? teacherProfileModel;
  String displayName = "";
  int selectedIndex = 0;

  RxBool isLoading = false.obs;
  bool isFetchingCurrentClass = false;
  CurrentClassModel? currentClass;

  @override
  void onInit() {
    super.onInit();
    final teacherProfileController = Get.find<TeacherProfileController>();
    teacherProfileModel = teacherProfileController.teacherProfileModel;
    displayName = teacherProfileController.displayName;
    update();
  }

  Future<void> fetchCurrentClass() async {
    try {
      isFetchingCurrentClass = true;
      final response = await apiClient.get(ApiConstants.getCurrentClass,
          passToken: true, baseUrl: ApiConstants.apiBaseUrlNew);

      if (response.statusCode == 200 &&
          response.body['success'] == true &&
          response.body['data'] is List) {
        final dataList = response.body['data'] as List;
        if (dataList.isNotEmpty) {
          currentClass = CurrentClassModel.fromJson(dataList[0]);
          update();
        }
      }
    } catch (e) {
      currentClass = null;
    } finally {
      isFetchingCurrentClass = false;
      update();
    }
  }

  void changeIndex(int value) {
    selectedIndex = value;
    update();
  }
}
