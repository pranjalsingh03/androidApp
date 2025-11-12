import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/classroom/controllers/teacher_classroom_controller.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/components/action_card.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/components/classroom_actions.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/recent_tests.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/results_view.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/select_topic_view.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

import 'lesson_planning_screen.dart';
import 'notes_screen.dart';

class ClassroomHomeScreen extends StatefulWidget {
  const ClassroomHomeScreen({
    super.key,
  });

  @override
  State<ClassroomHomeScreen> createState() => _ClassroomHomeScreenState();
}

class _ClassroomHomeScreenState extends State<ClassroomHomeScreen> {
  final TeacherClassroomController controller =
      Get.find<TeacherClassroomController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 381.h,
                width: Get.width,
                child: Image.asset(
                  Assets.testOneClickImg,
                  fit: BoxFit.fitWidth,
                ),
              ),
              k16YGap,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var i = 0; i < classroomActions.length; i++)
                      GestureDetector(
                        onTap: () => Get.to(() => SelectTopicView(
                              type: classroomActions[i].type,
                              // classDetail: controller.selectedClass!,
                              // subject: controller.selectedSubject!,
                            )),
                        child: ActionCard(
                          entry: MapEntry(i, classroomActions[i]),
                        ),
                      ),
                  ],
                ),
              ),
              k16YGap,
              // Bottom
              GestureDetector(
                onTap: () {
                  Get.to(() => LessonPlanningScreen());
                },
                child: Container(
                  height: 100.h,
                  width: Get.width - 32.w,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.all(14.w),
                  decoration: ShapeDecoration(
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimensions.defaultRoundedCorner),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            'Lesson Planning',
                            style: kDark_14_500.copyWith(
                                color: AppColors.inverseTextColor),
                          ),
                          Text(
                            'Helps you plan a topic with engaging\nquiz, facts, group tasks',
                            style: kDark_10_400.copyWith(
                                color: AppColors.inverseTextColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        Assets.lessonPlanning,
                      )
                    ],
                  ),
                ),
              ),
              kdefaultYGap,
              // Notes & Assignment
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: featureCard(
                        title: 'Notes',
                        assetPath: Assets.classroomNotes,
                        onTap: () {
                          Get.to(() => const NotesScreen());
                        },
                      ),
                    ),
                    k16XGap,
                    Expanded(
                      child: featureCard(
                        title: 'Result',
                        assetPath: Assets.classroomAssignment,
                        onTap: () {
                          Get.to(()=>RecentTests());
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget featureCard({
    required String title,
    required String assetPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 162.h,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: kDefaultDecorationBordered,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset(assetPath),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: kDark_12_500,
                  ),
                  SvgPicture.asset(
                    Assets.arrowRight,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}