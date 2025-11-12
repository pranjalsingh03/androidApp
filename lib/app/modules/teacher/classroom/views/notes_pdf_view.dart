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
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';

class PdfViewScreen extends StatefulWidget {
  final String title;
  final String className;
  final String subjectName;
  final String chapterName;
  final String topics;

  PdfViewScreen({
    required this.title,
    required this.className,
    required this.subjectName,
    required this.chapterName,
    required this.topics,
  });

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  final TeacherClassroomRepository controller = Get.find<TeacherClassroomRepository>();

  @override
  void initState() {
    super.initState();
    // Call generateNotes method
    controller.generateNotes(
      className: widget.className,
      subjectName: widget.subjectName,
      chapterName: widget.chapterName,
      topics: widget.topics,
    );
  }

  @override
  void dispose() {
    // Delete the PDF file when the user navigates back
    if (controller.finalFile != null && controller.finalFile!.existsSync()) {
      controller.finalFile!.deleteSync();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          width: Get.width,
          height: Get.height,
          child: Obx(
            () => controller.isNotesPdfLoading.value.isSuccess
                ? SizedBox(
                    height: 380.h,
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
                : controller.isNotesPdfLoading.value.isLoading
                    ? const Center(child: Loader(text: "Getting Notes",))
                    : GestureDetector(
                        onTap: () => controller.generateNotes(
                          className: widget.className,
                          subjectName: widget.subjectName,
                          chapterName: widget.chapterName,
                          topics: widget.topics,
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

  Container pdfTile(String title, int idx, VoidCallback onPressed) {
    return Container(
      height: 150.h,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(10.w),
      decoration: UiConstants.defaultDecoration,
      child: Row(
        children: [
          Container(
            width: 50.w,
            margin: EdgeInsets.only(right: 10.w),
            child: Image.asset(AssetsConstants.bulb),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: UiConstants.dark_14_600,
                      ),
                    ),
                    Text(
                      "Note ${idx.toString()}",
                      style: UiConstants.dark_8_400.copyWith(
                        fontSize: 8.sp,
                        color: AppColors.tertiaryTextColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 30.h)),
                  onPressed: onPressed,
                  child: Row(
                    children: [
                      const Text("View Notes", style: UiConstants.light_10_400),
                      const Spacer(),
                      Icon(CupertinoIcons.chevron_right,
                          size: 10.w, color: Colors.white),
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