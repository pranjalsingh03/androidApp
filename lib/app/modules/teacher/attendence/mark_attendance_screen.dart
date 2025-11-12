import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/attendence/attendence_screen.dart';
import 'package:sheshya/app/modules/teacher/home/views/teacher_home_view.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/app/modules/teacher/attendence/components/attendence_card.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/theme/app_colors.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final AttendanceController controller = Get.find<AttendanceController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text("Mark Attendance"),
          leading: const AppBarBackButton(),
          actions: [
            Obx(() => !controller.isLoadingClass.value
                ? CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      '${controller.selectedClass.value}${controller.selectedSection.value}',
                      style: kLight_10_500,
                    ),
                  )
                : const SizedBox.shrink()),
            k16XGap,
          ],
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 50),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(right: Dimensions.defaultPadding),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text('present', style: darknormal14),
                      SizedBox(width: 4),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                        ),
                        child:
                            Icon(Icons.circle, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Row(
                    children: [
                      Text('absent', style: darknormal14),
                      SizedBox(width: 4),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero),
                        ),
                        child:
                            Icon(Icons.circle, color: AppColors.bodyTextColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.defaultPadding,
            right: Dimensions.defaultPadding,
          ),
          child: Column(
            children: [
              k16YGap,
              Expanded(
                child: SingleChildScrollView(
                  child: controller.isFetchingStudents
                      ? SizedBox(
                          height: Get.height - 200.h,
                          child: const Center(
                            child: Loader(text: "Getting Students..."),
                          ),
                        )
                      : controller.students.isEmpty
                          ? SizedBox(
                              height: Get.height - 200.h,
                              child: const Center(
                                child: Text('No Students found'),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: Dimensions.defaultPadding,
                                crossAxisSpacing: Dimensions.defaultPadding,
                                mainAxisExtent: 50,
                              ),
                              itemCount: controller.students.length,
                              itemBuilder: (context, index) {
                                final student = controller.students[index];
                                return AttendanceCard(
                                  student: student,
                                  isSelected: controller.selectedStudents
                                      .contains(student.studentId),
                                );
                              },
                            ),
                ),
              ),
              const SizedBox(height: 16),
              controller.isMarkingAttendance
                  ? const Loader(text: "Marking Attendance...")
                  : CustomButton(
                      buttonText: "Mark Attendance",
                      onPressed: () async {
                        final bool success = await controller.markAttendance();
                        if (success) {
                          Get.back();
                        }
                      },
                    ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}