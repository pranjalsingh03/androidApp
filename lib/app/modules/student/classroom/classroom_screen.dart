import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/modules/student/assignment_test/assignment_test_screen.dart';
import 'package:sheshya/app/modules/student/notes/notes_screen.dart';
import 'package:sheshya/app/modules/student/student_result/student_result_screen.dart';
import 'package:sheshya/theme/app_colors.dart';

class ClassroomScreen extends StatefulWidget {
  static const routeName = "/classroom";
  const ClassroomScreen({super.key});

  @override
  State<ClassroomScreen> createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Hero card
              Container(
                height: 330.h,
                width: Get.width,
                color: AppColors.whiteColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF467CFA),
                          Color(0xFF308DF8),
                          Color(0xFF18A0F5),
                          Color(0xFF16A6FF),
                          Color(0xFF0F7DFF),
                          Color(0xFF467CFB),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Text(
                        "Classroom",
                        style:
                            UiConstants.dark_18_600.copyWith(fontSize: 28.sp),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text("Your Digital Class",
                        style: UiConstants.secondary_18_400.copyWith(
                          fontSize: 20.sp,
                        )),
                    SizedBox(height: 50.h),
                    SvgPicture.asset(AssetsConstants.classroomHeader),
                  ],
                ),
              ),
              SizedBox(height: 23.h),
              // Subjects
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Subjects", style: UiConstants.dark_16_600),
              ),
              SizedBox(height: 16.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    subjectCard(
                        subjectName: "Mathematics",
                        imgPath: AssetsConstants.math,
                        isFirst: true),
                    subjectCard(
                      subjectName: "Science",
                      imgPath: AssetsConstants.science,
                    ),
                    subjectCard(
                      subjectName: "Social Science",
                      imgPath: AssetsConstants.socialScience,
                    ),
                    subjectCard(
                      subjectName: "Hindi",
                      imgPath: AssetsConstants.hindi,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),

              //Result & notes
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("See the Results and Notes",
                    style: UiConstants.dark_16_600),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.toNamed(StudentResultScreen.routeName),
                        child: Container(
                          height: 141.h,
                          decoration: UiConstants.defaultDecorationBordered,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child:
                                    SvgPicture.asset(AssetsConstants.result2),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Result",
                                    style: UiConstants.dark_14_600,
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
                    const SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        // onTap: () => Get.toNamed(NotesScreen.routeName),
                        child: Container(
                          height: 141.h,
                          decoration: UiConstants.defaultDecorationBordered,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SvgPicture.asset(AssetsConstants.notes2),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Notes",
                                    style: UiConstants.dark_14_600,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget subjectCard({
    required String subjectName,
    required String imgPath,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(AssignmentTestScreen.routeName, arguments: subjectName),
      child: Container(
        padding: EdgeInsets.only(
          left: isFirst ? 16.w : 8.w,
          right: isLast ? 16.w : 8.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 87.h,
              width: 92.h,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  UiConstants.defaultRoundedCorner,
                ),
                color: AppColors.whiteColor,
                border: Border.all(
                  width: 1,
                  color: AppColors.textColor,
                ),
              ),
              child: Image.asset(imgPath),
            ),
            SizedBox(height: 12.h),
            Text(subjectName, style: UiConstants.dark_10_500),
          ],
        ),
      ),
    );
  }
}
