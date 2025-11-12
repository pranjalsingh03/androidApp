import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/app/data/model/ui_models/coming_soon_screen.dart';
import 'package:sheshya/app/modules/parent/behaviour_report/behaviour_report_screen.dart';
import 'package:sheshya/app/modules/student/ai_chat/ai_chat.dart';
import 'package:sheshya/app/modules/student/ai_chat/ask_anything_sheshya_ai.dart';
import 'package:sheshya/app/modules/student/ai_classroom/ai_classroom.dart';
import 'package:sheshya/app/modules/student/schedule_screen.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/modules/parent/parent_home/parent_home_screen.dart';
import 'package:sheshya/app/modules/parent/parent_notification/parent_notification_screen.dart';
import 'package:sheshya/app/modules/student/ai/ai_screen.dart';
import 'package:sheshya/app/modules/student/class_activity/class_activity_screen.dart';
import 'package:sheshya/app/modules/student/classroom/classroom_screen.dart';
import 'package:sheshya/app/modules/student/student_result/student_result_screen.dart';
import 'package:sheshya/app/modules/student/upcoming_exam/upcoming_exam_screen.dart';
import 'package:sheshya/theme/app_colors.dart';

import '../../../../constants/styles.dart';
import '../../parent/parent_home/parent_home_controller.dart';
import '../../parent/profile/parent_profile_screen.dart';

class StudentDashboardScreen extends  GetView<ParentHomeController> {
  static const routeName = "/student-dashboard";
   StudentDashboardScreen({super.key});

  @override
  final ParentHomeController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // App Bar
              appBar(),
              pendingCard(),
              SizedBox(height: 18.h),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: homeActionCard(),
              ),
              SizedBox(height: 16.h),
              // selectedRangeCard(),
              // SizedBox(height: 16.h),
              // rangeCard(),
              SizedBox(height: 16.h),
              resultCard(),
              SizedBox(height: 16.h),
              examCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(width: 2, color: AppColors.dividercolor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsConstants.backHome,
                      height: 20,
                    ),
                    Text(
                      "Sheshya",
                      style: kDark_10_400.copyWith(
                        color: AppColors.unSelectedItemColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsConstants.child,
                      colorFilter: ColorFilter.mode(AppColors.selectedItemColor,
                          BlendMode.srcIn),
                    ),
                    Text(
                      "Student",
                      style: kDark_10_400.copyWith(
                        color: AppColors.unSelectedItemColor,
                        fontWeight
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap:()=>Get.to(const AiClassroom()),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsConstants.classRoom,
                      colorFilter: ColorFilter.mode(AppColors.unSelectedItemColor,
                          BlendMode.srcIn),
                    ),
                    Text(
                      "Classroom",
                      style: kDark_10_400.copyWith(
                        color: AppColors.unSelectedItemColor,
                        fontWeight:FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>Get.to(SchedulePage()),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsConstants.schedule,
                      colorFilter: const ColorFilter.mode(AppColors.unSelectedItemColor, BlendMode.srcIn),
                    ),
                    Text(
                      "Schedule",
                      style: kDark_10_400.copyWith(
                        color: AppColors.unSelectedItemColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>Get.to(const ParentProfileScreen()),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsConstants.user,
                      colorFilter: ColorFilter.mode(AppColors.unSelectedItemColor, BlendMode.srcIn),
                    ),
                    Text(
                      "Profile",
                      style: kDark_10_400.copyWith(
                        color: AppColors.unSelectedItemColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Padding examCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => Get.to(()=>ComingSoonScreen()),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(UiConstants.defaultRoundedCorner)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Exams",
                    style: UiConstants.dark_14_600
                        .copyWith(color: AppColors.inverseTextColor),
                  ),
                  Text(
                    "Olympiads | Scholarships",
                    style: UiConstants.dark_14_400
                        .copyWith(color: AppColors.inverseTextColor),
                  ),
                ],
              ),
              SvgPicture.asset(AssetsConstants.exams),
            ],
          ),
        ),
      ),
    );
  }

  Padding resultCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => Get.to(()=>ComingSoonScreen()),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: UiConstants.defaultDecorationBordered,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mind Test",
                    style: UiConstants.dark_14_600,
                  ),
                  Text(
                    "Test your Mind Ability",
                    style: UiConstants.dark_14_500,
                  ),
                ],
              ),
              SvgPicture.asset(AssetsConstants.mindTest),
            ],
          ),
        ),
      ),
    );
  }

  Container rangeCard() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          days.length,
          (i) => GestureDetector(
            onTap: () => Get.toNamed(ClassActivityScreen.routeName),
            child: Container(
              height: 60.h,
              padding: const EdgeInsets.all(10),
              decoration: UiConstants.defaultDecoration,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    days[i].dayCode,
                    textAlign: TextAlign.center,
                    style: UiConstants.secondary_12_400,
                  ),
                  CircleAvatar(
                    radius: 8,
                    backgroundColor: days[i].status == DayStatus.PAST
                        ? AppColors.primaryLowVersionColor
                        : days[i].status == DayStatus.UPCOMING
                            ? AppColors.tertiaryTextColor
                            : AppColors.accentColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row selectedRangeCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.chevron_left,
          color: AppColors.tertiaryTextColor,
        ),
        const SizedBox(width: 4),
        Text(
          'This week',
          style: UiConstants.dark_14_500.copyWith(
            color: AppColors.tertiaryTextColor,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.chevron_right,
          color: AppColors.tertiaryTextColor,
        ),
      ],
    );
  }

  Widget homeActionCard() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(AskAnythingSheshyaAiView());
            },
            child: Container(
              height: 180.h,
              decoration: ShapeDecoration(
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(UiConstants.defaultRoundedCorner),
                  ),
                  ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SvgPicture.asset(AssetsConstants.sheshyaAi),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sheshya AI",
                        style: UiConstants.dark_14_500
                            .copyWith(color: AppColors.inverseTextColor),
                      ),
                      SvgPicture.asset(
                        Assets.arrowRight,
                        colorFilter: UiConstants.kSvgLightFilter,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: () => Get.to(const AiClassroom()),
            child: Container(
              height: 180.h,
              decoration: UiConstants.defaultDecorationBordered,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SvgPicture.asset(AssetsConstants.classroom),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Classroom",
                        style: UiConstants.darkk_14_500,
                      ),
                      SvgPicture.asset(
                        Assets.arrowRight,
                        colorFilter: UiConstants.kSvgDarkFilter,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
Container pendingCard() {
  return Container(
    height: 84.h,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14.5, vertical: 1),
    decoration: BoxDecoration(
      color: Color(0xFF2C87FF), // Orange background
      borderRadius: BorderRadius.circular(5),
      
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome User",
              style: UiConstants.light_14_400,
            ),
            Text(
              "Explore the AI Ecosystem",
              style: UiConstants.light_14_400,
            ),
          ],
        ),
        // Placeholder for additional widget (e.g., a button or icon)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: const Text(
            "🎉", // Robot emoji
            style: TextStyle(fontSize: 28), // Adjust size as needed
  ),
        ),
      ],
    ),
  );
}
  // Container pendingCard() {
  //   return Container(
  //     height: 84.h,
  //     margin: const EdgeInsets.symmetric(horizontal: 16),
  //     padding: const EdgeInsets.symmetric(horizontal: 14.5, vertical: 6.5),
  //     decoration: UiConstants.defaultDecorationBordered,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text(
  //               "Pending Test",
  //               style: UiConstants.dark_16_600,
  //             ),
  //             const Text(
  //               "Physics | Light",
  //               style: UiConstants.secondary_12_400,
  //             ),
  //             Text(
  //               "20 Questions | 10 MCQ, 5 Fill in the blanks, 5 T/F",
  //               style: UiConstants.dark_8_400
  //                   .copyWith(color: AppColors.tertiaryTextColor),
  //             )
  //           ],
  //         ),
  //         Container(
  //           padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
  //           decoration: ShapeDecoration(
  //             color: AppColors.primaryColor,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(1.75),
  //             ),
  //           ),
  //           child: Text(
  //             "Due 12th July",
  //             style: TextStyle(
  //               color: AppColors.inverseTextColor,
  //               fontSize: 7.5.sp,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Container appBar() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      width: Get.width.w,
      height: UiConstants.appBarHeight.h,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(controller.studentProfileResModel?.data?.basic?.name ?? '--',
              style: UiConstants.appBarTitle.copyWith(fontSize: 17.sp)),
          const SizedBox(width: 14),
          SvgPicture.asset(AssetsConstants.arrowDown),
          const Spacer(),
          IconButton(
            onPressed: () => Get.to(() => ParentNotificationScreen()),
            icon: SvgPicture.asset(
              AssetsConstants.notification,
              height: 22.h,
              width: 22.w,
            ),
          ),
        ],
      ),
    );
  }
}
