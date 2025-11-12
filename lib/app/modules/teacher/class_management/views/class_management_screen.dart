import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/class_student_screen.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/controllers/class_management_controller.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/system_ui.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';

class ClassManageMentScreen extends StatefulWidget {
  const ClassManageMentScreen({super.key});

  @override
  State<ClassManageMentScreen> createState() => _ClassManageMentScreenState();
}

class _ClassManageMentScreenState extends State<ClassManageMentScreen> {
  final ApiClient apiClient = ApiClient();
  final ManagementController controller = Get.find<ManagementController>();
  final AttendanceController attcontroller = Get.find<AttendanceController>();
  final TextEditingController searchController = TextEditingController();
  bool isClassesFetching = false;
  List<dynamic>? classes;

  @override
  void initState() {
    super.initState();
    getTeacherClasses();
  }

  Future<void> getTeacherClasses() async {
    try {
      setState(() {
        isClassesFetching = true;
      });
      var response = await apiClient.get(ApiConstants.teacherClasses);
      setState(() {
        classes = response.body["data"] as List<dynamic>;
      });
    } catch (e) {
      showCustomSnackBar("Error fetching teacher classes");
    } finally {
      if (mounted) {
        setState(() {
          isClassesFetching = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUi.defaultStyle,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const AppBarBackButton(),
          title: const Text('Class Management'),
        ),
        body: isClassesFetching
            ? const Center(child: Loader(text: "Getting your classes"))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.defaultPadding),
                      // TextField(
                      //   onTapOutside: (event) =>
                      //       FocusScope.of(context).unfocus(),
                      //   controller: searchController,
                      //   decoration: InputDecoration(
                      //     isDense: true,
                      //     prefixIconConstraints: const BoxConstraints(
                      //       maxWidth: 55,
                      //     ),
                      //     border: const OutlineInputBorder(),
                      //     hintText: 'Search students',
                      //     prefixIcon: Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 16),
                      //       child: SvgPicture.asset(
                      //         Assets.searchIcon,
                      //         width: 18,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: Dimensions.defaultPadding),
                      Text(
                        'My Classes',
                        style: lightsemibold16.copyWith(fontSize: 18),
                        textScaler: TextScaler.noScaling,
                      ),
                      const SizedBox(height: Dimensions.defaultPadding),
                      if (classes != null && classes!.isNotEmpty)
                        Wrap(
                          spacing: Dimensions.defaultPadding,
                          runSpacing: Dimensions.defaultPadding,
                          children: List.generate(
                            classes!.length,
                            (index) {
                              final classData = classes![index];
                              return SizedBox(
                                width: (MediaQuery.of(context).size.width -
                                        Dimensions.defaultPadding * 3) /
                                    2,
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    controller.updateSelectedClass(
                                        className:
                                            classData["className"] ?? '',
                                        section:classData["section"] ?? '',
                                        sectionId:
                                            classData["_id"] ?? '');
                                    controller.fetchStudents(classData['_id']); // Fetch students for the selected class and section
                                    Get.to(() => const ClassStudentScreen());
                                  },
                                  child: Container(
                                    height: 60,
                                    decoration: kDefaultDecoration,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          classData["className"] ?? '',
                                          style: kDark_18_500,
                                        ),
                                        k4XGap,
                                        Text(
                                          classData["section"] ?? '',
                                          style: kDark_18_500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      else
                        const Center(
                          child: Text('No classes found'),
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}