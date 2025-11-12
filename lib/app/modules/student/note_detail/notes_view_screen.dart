import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/modules/student/notes/notes_controller.dart';

class NotesViewScreen extends GetView<NotesController> {
  @override
  Widget build(BuildContext context) {
    // Load the PDF when the screen is built
    controller.loadNotesPdf();

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Notes"),
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
                      filePath: controller.finalFile.path,
                      onRender: (_pages) {
                        controller.pages.value = _pages ?? 0;
                        controller.isReady.value = true;
                      },
                      onError: (error) {
                        controller.errorMessage.value = error.toString();
                        print(error.toString());
                      },
                      onPageError: (page, error) {
                        controller.errorMessage.value = '$page: ${error.toString()}';
                        print('$page: ${error.toString()}');
                      },
                      onViewCreated: (PDFViewController pdfViewController) {
                        if (!controller.pdfcontroller.value.isCompleted) {
                          controller.pdfcontroller.value.complete(pdfViewController);
                        }
                      },
                    ),
                  )
                : controller.isNotesPdfLoading.value.isLoading
                    ? Center(
                        child: Loader(text: "Getting Notes"),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.loadNotesPdf();
                        },
                        child: Text('Retry'),
                      ),
          ),
        ),
      ),
    );
  }

  Container noteTile(String chapterName, int idx) {
    return Container(
      height: 110.h,
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
                        style: UiConstants.dark_14_600,
                      ),
                    ),
                    Text(
                      "Note ${idx.toString()}",
                      style: UiConstants.dark_8_400.copyWith(
                          fontSize: 8.sp, color: AppColors.tertiaryTextColor),
                    ),
                  ],
                ),
                // Subtitle
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30.h),
                  ),
                  onPressed: () {
                    controller.loadNotesPdf();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                        "View Notes",
                        style: UiConstants.light_10_400,
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