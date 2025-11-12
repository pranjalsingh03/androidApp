import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/teacher/response/class_detail_model.dart';
import 'package:sheshya/app/data/model/teacher/response/subject_model.dart';
import 'package:sheshya/app/data/respository/teacher/teacher_classroom_repo.dart';
import 'package:sheshya/app/modules/teacher/classroom/controllers/teacher_classroom_controller.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/classroom_root_screen.dart';
import 'package:sheshya/components/custom_appbar.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';

class ClassroomSelectScreen extends StatefulWidget {
  const ClassroomSelectScreen({super.key});

  @override
  State<ClassroomSelectScreen> createState() => _ClassroomSelectScreenState();
}

class _ClassroomSelectScreenState extends State<ClassroomSelectScreen> {
  final TeacherClassroomController controller =
      Get.find<TeacherClassroomController>();

  bool isLoading = true;
  bool isSwiped = true;
  String loadingText = 'Getting Classes...';

  List<ClassDetailModel>? classes;
  List<SubjectModel>? subjects;

  ClassDetailModel? selectedClass;
  SubjectModel? selectedSubject;

  @override
  void initState() {
    super.initState();
    fetchClasses();
  }

  void setClass({required ClassDetailModel classDetailModel}) {
    setState(() {
      selectedClass = classDetailModel;
      selectedSubject = null;
      subjects = null;
    });
    fetchSubjects();
  }

  Future<void> fetchClasses() async {
    try {
      final res = await TeacherClassroomRepository().getAllClassesList();
      if (mounted) {
        if (res.$1) {
          classes = res.$2;
        } else {
          showCustomSnackBar(res.$3);
        }
        isLoading = false;
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        isLoading = false;
        setState(() {});
        showCustomSnackBar('Something went wrong');
      }
    }
  }

  Future<void> fetchSubjects() async {
    if (selectedClass == null) return;
    isLoading = true;
    loadingText = 'Getting Subjects...';
    setState(() {});
    final res = await TeacherClassroomRepository().getAllSubjectsByClass(
      className: selectedClass!.classId,
    );

    if (res.$1) {
      subjects = res.$2;
    } else {
      showCustomSnackBar(res.$3);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.whiteColor,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            // Background SVG
            SvgPicture.asset(
              Assets.classroomSelect,
              fit: BoxFit.contain,
              width: Get.width,
              height: Get.height-355.h,
            ),
            // Main content
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              height: Get.height,
              width: Get.width,
              color: isSwiped ? Colors.transparent : Colors.white,
              child: !isSwiped
                  ? Draggable(
                      data: 0,
                      axis: Axis.vertical,
                      childWhenDragging: Container(),
                      onDragEnd: (details) {
                        if (details.velocity.pixelsPerSecond.dy < -1000) {
                          setState(() {
                            isSwiped = true;
                          });
                        }
                      },
                      feedback: SvgPicture.asset(
                        Assets.classroomExplore,
                        fit: BoxFit.fitWidth,
                        width: Get.width,
                      ),
                      child: SvgPicture.asset(
                        Assets.classroomExplore,
                        fit: BoxFit.fitWidth,
                        width: Get.width,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Spacer(),
                        isLoading
                            ? Loader(text: "")
                            : Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  DropdownButton(
                                    value: selectedClass,
                                    isExpanded: true,
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(8),
                                    selectedItemBuilder: (context) => classes
                                            ?.map((e) =>
                                                Text("Class ${e.className}"))
                                            .toList() ??
                                        [],
                                    hint: Text(
                                      'Select Class',
                                      style: kDark_16_500,
                                    ),
                                    icon: const Icon(
                                      CupertinoIcons.chevron_down,
                                      color: AppColors.primaryColor,
                                    ),
                                    items: classes
                                        ?.map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e.className),
                                            ))
                                        .toList(),
                                    onChanged: (value) => setClass(
                                      classDetailModel: value!,
                                    ),
                                  ),
                                  kdefaultYGap,
                                  if (subjects != null)
                                    DropdownButton(
                                      value: selectedSubject,
                                      elevation: 1,
                                      isExpanded: true,
                                      borderRadius: BorderRadius.circular(8),
                                      selectedItemBuilder: (context) => subjects
                                              ?.map((e) =>
                                                  Text(e.subjectName))
                                              .toList() ??
                                          [],
                                      hint: Text(
                                        'Select Subject',
                                        style: kDark_16_500,
                                      ),
                                      icon: const Icon(
                                        CupertinoIcons.chevron_down,
                                        color: AppColors.primaryColor,
                                      ),
                                      items: subjects
                                          ?.map((e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e.subjectName),
                                              ))
                                          .toList(),
                                      onChanged: (value) => setState(() {
                                        selectedSubject = value;
                                      }),
                                    ),
                                  k20YGap,
                                  CustomButton(
                                    buttonText: "Continue",
                                    onPressed: selectedSubject == null ||
                                            selectedClass == null
                                        ? null
                                        : () {
                                            controller
                                                .updateSelectedClassAndSubject(
                                              classDetailModel: selectedClass!,
                                              subjectModel: selectedSubject!,
                                            );
                                            Get.to(
                                              () => const ClassroomRootScreen(),
                                            );
                                          },
                                  ),
                                  kdefaultYGap,
                                ],
                              ),
                        if (isLoading) const Spacer()
                      ],
                    ),
            ),
            // Blurred overlay when loading
            if (isLoading)
              Container(
              height: Get.height,
              width: Get.width,
              color: AppColors.backgroundColor, // Complete white background
              child: const Center(
                child: Loader(text: "Loading.."), // Loader in the center
              ),
              ),
          ],
        ),
      ),
    );
  }
}