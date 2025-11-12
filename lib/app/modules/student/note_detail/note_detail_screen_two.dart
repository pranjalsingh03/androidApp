import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/modules/student/notes/notes_controller.dart';

import 'notes_view_screen.dart';

class NoteDetailScreenTwo extends GetView<NotesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Notes List"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          width: Get.width,
          height: Get.height,
          child: ListView.builder(
            itemCount: controller.chapterResModelNotes?.data?[controller.selectedChapterIdx.value].topics?.length ?? 0,
            itemBuilder: (ctx, idx) {
              return GestureDetector(
                onTap: () {
                  controller.selectedTopicIdx.value = idx;
                  Get.to(() => NotesViewScreen());
                },
                child: noteTile(
                  controller.chapterResModelNotes?.data?[controller.selectedChapterIdx.value].topics?[idx].topicName ?? '',
                  idx,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Container noteTile(String topicName, int idx) {
    return Container(
      height: 120.h,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(10.w),
      decoration: UiConstants.defaultDecoration,
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
                        topicName,
                        style: UiConstants.dark_14_600,
                      ),
                    ),
                  ],
                ),
                // Subtitle
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30.h),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent
                  ),
                  onPressed: () {
                    controller.selectedTopicIdx.value = idx;
                    Get.to(() => NotesViewScreen());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "           ",
                        style: UiConstants.light_10_400 .copyWith(
                          fontSize: 10.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 10.w,
                        color: AppColors.primaryColor,
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