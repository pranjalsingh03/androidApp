import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/api/api_client.dart';
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/data/model/teacher/response/mcq_model.dart';
import 'package:sheshya/app/data/respository/teacher/teacher_classroom_repo.dart';
import 'package:sheshya/app/modules/teacher/classroom/controllers/teacher_classroom_controller.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/classroom_root_screen.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/components/difficulty_selector.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/components/topic_name_card.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/custom_print.dart';
import 'package:sheshya/theme/app_colors.dart';

class McqView extends StatefulWidget {
  final String className;
  final String subjectName;
  final String chapterName;
  final List<String> topics;
  final String questionType;
  final int totalQuestions;

  const McqView({
    super.key,
    required this.className,
    required this.subjectName,
    required this.chapterName,
    required this.topics,
    required this.questionType,
    required this.totalQuestions,
  });

  @override
  State<McqView> createState() => _McqViewState();
}

class _McqViewState extends State<McqView> {
  final TeacherClassroomController controller =
      Get.find<TeacherClassroomController>();

  bool isLoading = false;
  bool isSharing = false;
  String difficulty = "easy";
  List<String> difficulties = ["easy", "medium", "hard"];
  Map<String, dynamic>? mcqQuestionModel;
  List<Map<String, dynamic>> teacherClasses = [];

  McqModel? mcqModel;

  List<String> selectedClasses = [];
  DateTime selectedDate = DateTime.now();
  
  static ApiClient apiClient = ApiClient();
  @override
  void initState() {
    super.initState();
    generateMcqs();
    fetchTeacherClasses();
  }

  void changeDifficulty(String value) {
    if (value == difficulty) return;

    setState(() {
      difficulty = value;
    });

    generateMcqs();
  }

  void fetchTeacherClasses() async {
    final res = await TeacherClassroomRepository().getTeacherClasses();
    if (res.$1) {
      if (mounted) {
        setState(() {
          teacherClasses = res.$2!;
          customPrint("Teacher Classes: ${teacherClasses}");
        });
      }
    } else {
      showCustomSnackBar(res.$3);
    }
  }

  void showAssignPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title Row with Close Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Share Test",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.close, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Select Classes Title
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Class",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 8),

                    // Class Selection Grid
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: teacherClasses.map((classItem) {
                        bool isSelected = selectedClasses.contains(classItem['_id']);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedClasses.remove(classItem['_id']);
                              } else {
                                selectedClasses.add(classItem['_id']);
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "${classItem['className']} ${classItem['section']}",
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 15),

                    // Deadline Label
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Deadline",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(height: 8),

                    // Deadline Date Picker
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Share Test Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (mounted) {
                            setState(() {
                              isSharing = true;
                            });
                          }
                          await assignAssignment(selectedClasses, selectedDate);
                          if (mounted) {
                            setState(() {
                              isSharing = false;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: isSharing
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text(
                                "Share Test",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> assignAssignment(List<String> selectedClasses, DateTime deadline) async {
    customPrint("Selected Classes: $selectedClasses");
    customPrint("Deadline: $deadline");
    customPrint("Assignment ID: ${mcqModel!.id}");
    final res = await apiClient.post(
      baseUrl: ApiConstants.apiBaseUrlNew,
      ApiConstants.assignAssignment, {
        "sclassId": selectedClasses,
        "assignmentId": mcqModel!.id,
        "deadline": deadline.toIso8601String(),
      });

    if (res.statusCode == 200) {
      showCustomSnackBar("Assignment shared successfully", type: SnackBarType.success);
      Get.offAll(() => ClassroomRootScreen());
    } else {
      showCustomSnackBar(res.body['message'], type: SnackBarType.error);
    }
  }

  void generateMcqs() async {
    setState(() {
      isLoading = true;
    });

    final res = await TeacherClassroomRepository().generateMcqAssignment(
      className: controller.selectedClass!.className,
      subjectName: controller.selectedSubject!.subjectName,
      chapterName: widget.chapterName,
      topics: widget.topics,
      questionType: widget.questionType,
      totalQuestions: widget.totalQuestions,
      level: difficulty,
    );

    if (res.$1) {
      mcqModel = res.$2;
    } else {
      showCustomSnackBar(res.$3);
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("MCQ Assesment"),
      ),
      body: isLoading
          ? const Center(
              child: Loader(
                text: "Generating MCQs",
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // Topic Name
                  kdefaultYGap,
                  // TopicNameCard(topics: widget.topics),
                  // kdefaultYGap,
                  DifficultySelector(
                    currentDifficulty: difficulty,
                    difficulties: difficulties,
                    onDifficultyChanged: changeDifficulty,
                  ),
                  kdefaultYGap,
                  // Mcqs
                  if (!isLoading && mcqModel == null)
                    Text(
                      "No Data Found",
                      style: kDark_12_500.copyWith(
                        color: AppColors.accentColor,
                      ),
                    ),
                  if (mcqModel != null)
                    for (var i = 0; i < mcqModel!.questions.length; i++)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.defaultPadding,
                          vertical: 8.h,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        width: Get.width - 32,
                        decoration: kDefaultDecorationBordered,
                        child: Column(
                          children: [
                            k8YGap,
                            Container(
                              width: Get.width,
                              // decoration: kDefaultDecorationBordered,
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 8.h,
                              ),
                              child: Text(
                                "${i + 1}. ${mcqModel!.questions[i].question}",
                                style: kDark_10_500,
                              ),
                            ),
                            k12YGap,
                            for (var j = 0;
                                j < mcqModel!.questions[i].options.length;
                                j++)
                              Container(
                                margin: EdgeInsets.only(bottom: 8.h),
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: mcqModel!.questions[i].correctAnswer ==
                                          mcqModel!.questions[i].options[j]
                                      ? AppColors.correctAnswerColor
                                      : Colors.white,
                                  // border: Border.all(
                                  //   // color: AppColors.strokeColor,
                                  //   width: 1,
                                  // ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 8.h,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${String.fromCharCode(65 + j)}. ${mcqModel!.questions[i].options[j]}",
                                        style: kDark_10_400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                ],
              ),
            ),
      bottomNavigationBar: mcqModel == null || isLoading
          ? null
          : Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.defaultPadding,
                vertical: 8.h,
              ),
              child: GestureDetector(
                onTap: () {
                  showAssignPopup(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 48.h,
                  decoration: ShapeDecoration(
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          Dimensions.defaultRoundedCorner),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Assign",
                        style: kLight_14_600,
                      ),
                      // SvgPicture.asset(
                      //   Assets.arrowRight,
                      //   width: 24.r,
                      //   height: 24.r,
                      //   colorFilter: const ColorFilter.mode(
                      //     AppColors.inverseTextColor,
                      //     BlendMode.srcIn,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}