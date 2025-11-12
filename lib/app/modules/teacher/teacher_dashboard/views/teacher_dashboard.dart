import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/app/modules/error/error_screen.dart';
import 'package:sheshya/app/modules/teacher/attendence/root_screen.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/class_management_screen.dart';
import 'package:sheshya/app/modules/teacher/error/views/error_view.dart';
import 'package:sheshya/app/modules/teacher/exams/examination_screen.dart';
import 'package:sheshya/app/modules/teacher/home/controllers/teacher_home_controller.dart';
import 'package:sheshya/app/modules/teacher/journal/views/journal_screen.dart';
import 'package:sheshya/app/modules/teacher/notification/views/teacher_notification_screen.dart';
import 'package:sheshya/app/modules/teacher/teacher_dashboard/views/components/progress_tile.dart';
import 'package:sheshya/app/modules/teacher/teacher_dashboard/views/components/upcoming_class_section_card.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/teacher_attendance_screen.dart';
import 'package:sheshya/app/modules/teacher/timetable/views/timetable_screen.dart';
import 'package:sheshya/app/routes/app_pages.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/components/action_icon.dart';
import 'package:sheshya/components/feature_card.dart';

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final TeacherHomeController homeController =
      Get.find<TeacherHomeController>();

  final TeacherProfileController teacherProfileController =
      Get.find<TeacherProfileController>();

  final isLoading = false;
  final hasNotification = false;
  final isAttendancePending = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.fetchCurrentClass();
      teacherProfileController.getTeacherTodaysAttendance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            // AppBar
            GetBuilder<TeacherProfileController>(
              builder: (controller) => Container(
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // Teacher Name
                    Text("Hi ${controller.displayName},", style: kAppBarText),
                    // Action Items
                    Row(
                      children: [
                        // Teacher Attendance Alert
                        GestureDetector(
                          onTap: () =>
                              Get.to(() => const TeacherAttendanceScreen()),
                          child: SvgPicture.asset(Assets.attendanceAlertIcon,
                              colorFilter: ColorFilter.mode(
                                controller.isTodaysAttendanceGiven
                                    ? AppColors.accentColor
                                    : AppColors.secondaryColor,
                                BlendMode.srcIn,
                              )),
                        ),
                        k16XGap,
                        // Teacher Notification
                        ActionIcon(
                          icon: Assets.notificationIcon,
                          onTap: () =>
                              Get.to(() => const TeacherNotificationScreen()),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            k20YGap,
            GetBuilder<TeacherHomeController>(
              builder: (controller) => !controller.isFetchingCurrentClass
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.defaultPadding),
                      margin: EdgeInsets.only(bottom: 16.h),
                      child: UpcomingClassSectionCard(
                          currentClass: controller.currentClass),
                    )
                  : const SizedBox.shrink(),
            ),
            // Teacher Data Input
            if (!teacherProfileController.teacherProfileModel!.isDataComplete)
              Container(
                margin: EdgeInsets.only(bottom: 20.h),
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
                child: ProgressTile(
                  title: "Your Progress",
                  isCompleted:
                      teacherProfileController.teacherProfileModel!.isDataComplete,
                ),
              ),
            // 1st Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: FeatureCard(
                      bgColor: AppColors.primaryColor,
                      textColor: Colors.white,
                      iconPath: Assets.aiIcon,
                      text: "Sheshya AI",
                      height: 188.h,
                      onTap: () => Get.toNamed(Routes.TEACHER_AI_CHAT,
                          arguments: teacherProfileController
                              .teacherProfileModel!.imageUrl ?? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                    ),
                  ),
                  k16XGap,
                  Expanded(
                    child: FeatureCard(
                      iconPath: Assets.attendanceCalendarIcon,
                      text: "Attendance",
                      onTap: () => Get.to(() => AttendanceRootScreen(
                            teacher:
                                teacherProfileController.teacherProfileModel!,
                          )),
                      height: 188.h,
                    ),
                  ),
                ],
              ),
            ),
            kdefaultYGap,
            // 2nd Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: FeatureCard(
                      iconPath: Assets.classManagementIcon,
                      text: "Class\nManagement",
                      onTap: () => Get.to(() => const ClassManageMentScreen()),
                      height: 164.h,
                    ),
                  ),
                  k16XGap,
                  Expanded(
                    child: SizedBox(
                      height: 164.h,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FeatureCardText(
                              text: "Schedule",
                              onTap: () => Get.to(
                                  () => const TeacherTimetableScreen()),
                              height: 73.h,
                              bgColor: AppColors.primaryColor,
                              textColor: AppColors.inverseTextColor,
                            ),
                          ),
                          k16YGap,
                          Expanded(
                            child: FeatureCardText(
                              text: "Chatbox",
                              onTap: () => homeController.changeIndex(3),
                              height: 73.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kdefaultYGap,
            // 3rd Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: FeatureCardText(
                      bgColor: AppColors.accentColor,
                      textColor: AppColors.inverseTextColor,
                      text: "Record\nJournal",
                      onTap: () => Get.to(() => const JournalScreen()),
                      height: 97.h,
                    ),
                  ),
                  k16XGap,
                  Expanded(
                    child: FeatureCardText(
                      text: "Upload\nMarks",
                      onTap: () {
                        Get.to(() => const ExaminationScreen());
                      },
                      height: 97.h,
                    ),
                  )
                ],
              ),
            ),
            k16YGap
          ],
        ),
      ),
    );
  }
}
