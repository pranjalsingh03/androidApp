import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/controllers/class_management_controller.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/student_profile_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/helper/custom_print.dart';
import 'package:sheshya/theme/app_colors.dart';

class ClassStudentScreen extends StatefulWidget {
  const ClassStudentScreen({
    super.key,
  });

  @override
  State<ClassStudentScreen> createState() => _ClassStudentScreenState();
}

class _ClassStudentScreenState extends State<ClassStudentScreen> {
  final ManagementController controller = Get.find<ManagementController>();

  @override
  void initState() {
    super.initState();
    controller.fetchStudents(controller.selectedSectionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text('Class Management'),
      ),
      body: GetBuilder<ManagementController>(
          builder: (controller) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: Dimensions.defaultPadding,
                        ),
                        Text(
                          '${controller.selectedClass} ${controller.selectedSection}',
                          style: darksemibold16.copyWith(fontSize: 18),
                          textScaler: TextScaler.noScaling,
                        ),
                        const SizedBox(
                          height: Dimensions.defaultPadding,
                        ),
                        controller.isFetchingStudents
                            ? const Center(
                                child: Loader(
                                  text: "Getting all Students",
                                ),
                              )
                            : GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.students.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing:
                                            Dimensions.defaultPadding,
                                        crossAxisSpacing:
                                            Dimensions.defaultPadding,
                                        mainAxisExtent:
                                            MediaQuery.of(context).size.height /
                                                15),
                                itemBuilder: (context, index) {
                                  var student = controller.students[index];
                                  return GestureDetector(
                                    onTap: () {
                                      controller.selectedStudent = student;
                                      customPrint('Student ID: ${student.studentId}');
                                      Get.to(
                                          () => StudentProfileScreen(
                                            studentId: student.studentId
                                          ));
                                    },
                                    child: Container(
                                      key: Key(index.toString()),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${index + 1}. ',
                                            style: darknormal12,
                                            textScaler: TextScaler.noScaling,
                                          ),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  AppColors.secondaryTextColor,
                                              image: DecorationImage(
                                                image:
                                                    NetworkImage(student.imageUrl),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width:
                                                Dimensions.defaultPadding / 2,
                                          ),
                                          Expanded(
                                              child: Text(
                                            student.name,
                                            style: darknormal12,
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            textScaler: TextScaler.noScaling,
                                          )),
                                          const SizedBox(
                                            width:
                                                Dimensions.defaultPadding / 2,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                        const SizedBox(
                          height: Dimensions.defaultPadding,
                        ),
                      ]),
                ),
              )),
    );
  }
}
