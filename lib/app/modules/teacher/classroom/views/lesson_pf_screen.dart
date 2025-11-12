import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sheshya/app/data/respository/teacher/teacher_classroom_repo.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';

class LessonPfScreen extends StatelessWidget {
  final String title;
  final String className;
  final String subjectName;
  final String chapterName;

  LessonPfScreen({
    required this.title,
    required this.className,
    required this.subjectName,
    required this.chapterName,
  });

  final TeacherClassroomRepository controller = Get.find<TeacherClassroomRepository>();

  @override
  Widget build(BuildContext context) {
    // Call generateLessonPlanning method
    controller.generateLessonPlanning(
      className: className,
      subjectName: subjectName,
      topic: chapterName,
    );

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: Text(title),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          width: Get.width,
          height: Get.height,
          child: Obx(
            () => controller.isLessonPlanningPdfLoading.value.isSuccess
                ? SizedBox(
                    height: 300.h,
                    width: 300.w,
                    child: PDFView(
                      filePath: controller.finalFile?.path ?? '',
                      onRender: (_pages) {
                        controller.pages.value = _pages ?? 0;
                        controller.isReady.value = true;
                      },
                      onError: (error) {
                        controller.errorMessage.value = error.toString();
                        print("PDF Error: $error");
                      },
                      onPageError: (page, error) {
                        controller.errorMessage.value =
                            '$page: ${error.toString()}';
                        print("PDF Page Error: $page: $error");
                      },
                      onViewCreated: (PDFViewController pdfViewController) {
                        if (!controller.pdfController.value.isCompleted) {
                          controller.pdfController.value
                              .complete(pdfViewController);
                        }
                      
                      },
                    ),
                  )
                : controller.isLessonPlanningPdfLoading.value.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GestureDetector(
                        onTap: () => controller.generateLessonPlanning(
                          className: className,
                          subjectName: subjectName,
                          topic: chapterName,
                        ),
                        child: const Center(
                            child:
                                Text('Retry', style: TextStyle(fontSize: 16))),
                      ),
          ),
        ),
      ),
    );
  }
}