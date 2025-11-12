import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/teacher/response/subject_model.dart';
import 'package:sheshya/app/modules/teacher/classroom/controllers/teacher_classroom_controller.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/lesson_pf_screen.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class LessonPlanningScreen extends StatelessWidget {
  const LessonPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TeacherClassroomController controller =
        Get.find<TeacherClassroomController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Planning'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          width: Get.width,
          height: Get.height,
          child: ListView.builder(
            itemCount: controller.selectedSubject!.chapters.length,
            itemBuilder: (context, index) {
              return lessonTile(
                controller.selectedSubject!.chapters[index].chapterName,
                controller.selectedSubject!.chapters[index].topics.length,
                index,
              );
            },
          ),
        ),
      ),
    );
  }

  Container lessonTile(String chapterName, int topicsLength, int idx) {
    final TeacherClassroomController controller =
        Get.find<TeacherClassroomController>();
    return Container(
      height: 150.h,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(10.w),
      decoration: kDefaultDecoration,
      child: Row(
        children: [
          Container(
            width: 106.w,
            margin: EdgeInsets.only(right: 10.w),
            child: Image.asset(AssetsConstants.bulb),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Text(
                        chapterName,
                        style: kDark_14_600,
                      ),
                    ),
                    Text(
                      "Chapter ${idx + 1}",
                      style: kDark_8_400.copyWith(
                          fontSize: 8.sp, color: AppColors.tertiaryTextColor),
                    ),
                  ],
                ),
                // Subtitle
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.star,
                      color: AppColors.accentColor,
                      size: 10.w,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      "$topicsLength Topics",
                      style: kDark_12_400.copyWith(
                          fontSize: 12.sp, color: AppColors.tertiaryTextColor),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30.h),
                  ),
                  onPressed: () {
                    Get.to(() => LessonPfScreen(
                      title: 'Lesson Planning',
                      className: controller.selectedClass!.className,
                      subjectName: controller.selectedSubject!.subjectName,
                      chapterName: chapterName,
                    ));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Create",
                        style: kLight_10_400,
                      ),
                      const Spacer(),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 10.w,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}