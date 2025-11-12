import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/modules/student/notes/notes_controller.dart';

import 'note_detail_screen_two.dart';

class NoteDetailScreen extends StatefulWidget {
  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final NotesController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.loadSubjectTopicDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Notes Details"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          width: Get.width,
          height: Get.height,
          child: Obx(() {
            if (controller.isChapterLoading.value.isLoading) {
              return Center(child: Loader(text: "Getting Details",));
            } else if (controller.isChapterLoading.value.isError) {
              return Center(child: Text("Error loading chapters"));
            } else {
              return ListView.builder(
                itemCount: controller.chapterResModelNotes?.data?.length ?? 0,
                itemBuilder: (ctx, idx) {
                  return noteTile(
                    controller.chapterResModelNotes?.data?[idx].chapterName ?? '',
                    controller.chapterResModelNotes?.data?[idx].topics?.length ?? 0,
                    idx,
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }

  Container noteTile(String chapterName, int topicsLength, int idx) {
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
                        chapterName,
                        style: UiConstants.dark_14_600,
                      ),
                    ),
                    Text(
                      "Chapter ${idx + 1}",
                      style: UiConstants.dark_8_400.copyWith(
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
                      style: UiConstants.dark_12_400.copyWith(
                          fontSize: 12.sp, color: AppColors.tertiaryTextColor),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30.h),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent
                  ),
                  onPressed: () {
                    controller.selectedChapterIdx.value = idx;
                    Get.to(()=>NoteDetailScreenTwo());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "           ",
                        style: UiConstants.light_10_400.copyWith(
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