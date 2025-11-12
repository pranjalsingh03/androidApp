import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/classroom/controllers/teacher_classroom_controller.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/components/classroom_actions.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/generate/fill_blanks_screen.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/generate/long_questions_screen.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/generate/mcq_view.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/generate/tf_view.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/generate/topic_wrap_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/classroom_helper.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';

class SelectTopicView extends StatefulWidget {
  final String type;

  const SelectTopicView({
    super.key,
    required this.type,
  });

  @override
  State<SelectTopicView> createState() => _SelectTopicViewState();
}

class _SelectTopicViewState extends State<SelectTopicView> {
  final TeacherClassroomController controller =
      Get.find<TeacherClassroomController>();

  TextEditingController numberOfQuestionsController = TextEditingController(
    text: "15",
  );

  List<String> topicsSelected = [];

  void toogleTopics(String topicName) {
    setState(() {
      if (topicsSelected.contains(topicName)) {
        topicsSelected.remove(topicName);
      } else {
        topicsSelected.add(topicName);
      }
    });
  }

  void navigate({required String chapterName}) {
    if (widget.type == 'mcq') {
      Get.to(
        () => McqView(
          topics: topicsSelected,
          chapterName: chapterName,
          className: controller.selectedClass!.className,
          subjectName: controller.selectedSubject!.subjectName,
          questionType: widget.type,
          totalQuestions: int.parse(numberOfQuestionsController.text),
        ),
      );
    } else if (widget.type == 't/f') {
      Get.to(
        () => TfView(
          topics: topicsSelected,
          chapterName: chapterName,
          className: controller.selectedClass!.className,
          subjectName: controller.selectedSubject!.subjectName,
          questionType: widget.type,
          totalQuestions: int.parse(numberOfQuestionsController.text),
        ),
      );
    } else if (widget.type == 'fill') {
      Get.to(
        () => FillBlanksScreen(
          topics: topicsSelected,
          chapterName: chapterName,
          className: controller.selectedClass!.className,
          subjectName: controller.selectedSubject!.subjectName,
          questionType: widget.type,
          totalQuestions: int.parse(numberOfQuestionsController.text),
        ),
      );
    } else if (widget.type == 'long') {
      Get.to(
        () => ShortLongQuestionScreen(
          topics: topicsSelected,
          chapterName: chapterName,
          className: controller.selectedClass!.className,
          subjectName: controller.selectedSubject!.subjectName,
          questionType: widget.type,
          totalQuestions: int.parse(numberOfQuestionsController.text),
        ),
      );
    } else if (widget.type == 'short') {
      Get.to(
        () => ShortLongQuestionScreen(
          topics: topicsSelected,
          chapterName: chapterName,
          className: controller.selectedClass!.className,
          subjectName: controller.selectedSubject!.subjectName,
          questionType: widget.type,
          totalQuestions: int.parse(numberOfQuestionsController.text),
        ),
      );
    } else if (widget.type == 'wrapup') {
      Get.to(
        () => TopicWrapScreen(
          topics: [chapterName],
          chapterName: chapterName,
          className: controller.selectedClass!.className,
          subjectName: controller.selectedSubject!.subjectName,
          questionType: "mcq",
          totalQuestions: int.parse(numberOfQuestionsController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: Text(ClassroomHelper.getTitle(type: widget.type)),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kdefaultYGap,
                // header(),
                Text(
                  "Select Number of Questions",
                  style: kDark_12_500,
                ),
                k8YGap,
                TextField(
                  controller: numberOfQuestionsController,
                  keyboardType: TextInputType.number,
                  onTapOutside: (value) => FocusScope.of(context).unfocus(),
                ),
                k16YGap,
                const Divider(color: AppColors.dividercolor),
                k8YGap,
                for (var i = 0;
                    i < controller.selectedSubject!.chapters.length;
                    i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        topicsSelected.clear();
                      });
                      FocusScope.of(context).unfocus();
                      if (widget.type == 'wrapup') {
                        navigate(
                          chapterName: controller
                              .selectedSubject!.chapters[i].chapterName,
                        );
                        return;
                      }
                      Get.bottomSheet(
                        isDismissible: true,
                        enableDrag: true,
                        isScrollControlled: true,
                        StatefulBuilder(
                          builder: (context, setState) => Container(
                            height: Get.height * 0.8,
                            decoration: const BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16.w),
                                  width: Get.width,
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(
                                            Dimensions.defaultRoundedCorner)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.selectedSubject!.chapters[i]
                                            .chapterName,
                                        style: kDark_16_600,
                                      ),
                                      Text(
                                        "Chapter ${i + 1}  |  ${controller.selectedSubject!.chapters[i].topics.length} Topics",
                                        style: kDark_12_400,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    color: AppColors.backgroundColor,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          for (var j = 0;
                                              j <
                                                  controller
                                                      .selectedSubject!
                                                      .chapters[i]
                                                      .topics
                                                      .length;
                                              j++)
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  toogleTopics(controller
                                                      .selectedSubject!
                                                      .chapters[i]
                                                      .topics[j]
                                                      .topicName);
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: 8.h,
                                                    top: j == 0 ? 16.h : 0),
                                                decoration:
                                                    kDefaultDecorationBordered,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.w,
                                                    vertical: 2.h),
                                                child: ListTile(
                                                  title: Text(
                                                    controller
                                                        .selectedSubject!
                                                        .chapters[i]
                                                        .topics[j]
                                                        .topicName,
                                                    style: kDark_12_400,
                                                  ),
                                                  trailing: Container(
                                                    width: 18.w,
                                                    height: 18.w,
                                                    decoration: ShapeDecoration(
                                                      color: topicsSelected
                                                              .contains(
                                                        controller
                                                            .selectedSubject!
                                                            .chapters[i]
                                                            .topics[j]
                                                            .topicName,
                                                      )
                                                          ? AppColors
                                                              .accentColor
                                                          : AppColors
                                                              .secondaryColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    100.r),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    
                                  ),
                                  child: ElevatedButton(
                                    onPressed: topicsSelected.isEmpty
                                        ? null
                                        : () {
                                            if (numberOfQuestionsController
                                                .text.isEmpty) {
                                              showCustomSnackBar(
                                                  "Please enter number of questions");
                                              return;
                                            }
                                            Get.back();
                                            navigate(
                                              chapterName: controller
                                                  .selectedSubject!
                                                  .chapters[i]
                                                  .chapterName,
                                            );
                                          },
                                    style: ElevatedButton.styleFrom(
                                      disabledBackgroundColor:
                                          AppColors.secondaryColor,
                                      minimumSize: Size(Get.width, 48.h),
                                    ),
                                    child: Text(
                                      "Continue",
                                      style: kLight_14_600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: kDefaultDecoration,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.secondaryColor,
                          child: Text(
                            "${i + 1}",
                            style: kDark_14_600.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                        title: Text(
                          controller.selectedSubject!.chapters[i].chapterName,
                          style: kDark_12_600.copyWith(fontSize: 13.sp),
                        ),
                        subtitle: widget.type == 'wrapup'
                            ? null
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star_border,
                                    color: AppColors.accentColor,
                                    size: 16.sp,
                                  ),
                                  k4XGap,
                                  Text(
                                    "${controller.selectedSubject!.chapters[i].topics.length} Topics",
                                    style: kSecondary_12_400,
                                  ),
                                ],
                              ),
                        trailing: SvgPicture.asset(Assets.arrowRight),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container header() {
    var text = ClassroomHelper.getSubtitle(type: widget.type);
    String title = text.$1;
    String subtitle = text.$2;

    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: kDefaultDecoration,
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: title,
                    style: kDark_12_600.copyWith(
                      color: AppColors.accentColor,
                    ),
                  ),
                  TextSpan(
                    text: subtitle,
                    style: kDark_12_400,
                  ),
                ],
              ),
            ),
          ),
          kdefaultXGap,
          SvgPicture.asset(
            classroomActions.firstWhere((e) => e.type == widget.type).assetPath,
            width: 68.w,
          ),
        ],
      ),
    );
  }
}
