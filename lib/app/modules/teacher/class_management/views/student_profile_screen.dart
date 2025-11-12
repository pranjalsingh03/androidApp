import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/achievements_screen.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/add_note_dialog.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/parent_message_dialog.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/feature_card.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/student_detail_small_card.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/controllers/class_management_controller.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/leave_attendance_screen.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/student_basic_detail_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/pref_constants.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/custom_print.dart';
import 'package:sheshya/theme/app_colors.dart';

class StudentProfileScreen extends StatefulWidget {
  final String studentId;

  const StudentProfileScreen({super.key, required this.studentId});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final ManagementController controller = Get.find<ManagementController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchStudentDetail(widget.studentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text(
          'Student Profile',
          textScaler: TextScaler.noScaling,
        ),
      ),
      body: GetBuilder<ManagementController>(
        builder: (_) => controller.isFetchingStudentDetail
            ? const Center(
                child: Loader(
                text: "Loading...",
              ))
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultPadding),
                  child: Column(
                    children: [
                      StudentDetailSmallCard(
                        imageUrl: controller.studentDetail?.imageUrl ?? "",
                        name: controller.studentDetail?.name ?? "",
                        subtitle:
                            "${controller.studentDetail?.className ?? ''} ${controller.studentDetail?.section ?? ''} | Roll No: ${controller.studentDetail?.rollNum ?? ''}",
                      ),
                      k16YGap,
                      Row(
                        children: [
                          Expanded(
                            child: FeatureCard(
                              title: 'Profile Details',
                              onTap: () => Get.to(
                                  () => const StudentBasicDetailScreen()),
                              backgroundColor: AppColors.accentColor,
                              foregroundColor: AppColors.inverseTextColor,
                              height: 97.h,
                            ),
                          ),
                          const SizedBox(width: Dimensions.defaultPadding),
                          // we have to change Academic card
                          Expanded(
                            child: FeatureCard(
                              title: 'Academics',
                              onTap: () {},
                              backgroundColor: AppColors.secondaryColor,
                              foregroundColor: AppColors.textColor,
                              height: 97.h,
                            ),
                          ),
                        ],
                      ),
                      k16YGap,
                      FeatureCard(
                        title: "Leave and Attendance",
                        onTap: () => Get.to(() =>  LeaveAttendanceScreen()),
                        backgroundColor: AppColors.whiteColor,
                        foregroundColor: AppColors.textColor,
                        height: 97.h,
                      ),
                      k16YGap,
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: FeatureCard(
                      //         title: "Achievement",
                      //         onTap: () =>
                      //             Get.to(() => const AchievementScreen()),
                      //         backgroundColor: AppColors.whiteColor,
                      //         foregroundColor: AppColors.textColor,
                      //         height: 164.h,
                      //       ),
                      //     ),
                      //     k16XGap,
                      //     Expanded(
                      //       child: FeatureCard(
                      //         title: "Chat",
                      //         onTap: () {},
                      //         backgroundColor: AppColors.whiteColor,
                      //         foregroundColor: AppColors.textColor,
                      //         height: 164.h,
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void showMessageParentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ParentMessageDialoge(controller: controller);
      },
    );
  }

  void showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddNotDialog(controller: controller);
      },
    );
  }
}