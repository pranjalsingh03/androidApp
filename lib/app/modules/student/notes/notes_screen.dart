import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/modules/student/note_detail/note_detail_screen.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'notes_controller.dart';

class NotesScreen extends GetView<NotesController> {
  @override
  Widget build(BuildContext context) {
    Get.put(NotesController());

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
          child: Obx(() => buildBody(context)),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    if (controller.isSubjectDetailsLoading.value.isLoading) {
      return Center(
        child: Loader(text: "Loading Subjects",),
      );
    }
    else if(controller.getSubjectDetailsResModel?.data?.isEmpty ?? true){
      return Center(child: Text("No Subjects Found"));
      }
     else if (controller.isSubjectDetailsLoading.value.isError) {
      return GestureDetector(
        onTap: () {
          controller.loadSubjectDetails();
        },
        child: Center(child: Text('Retry')),
      );
    } else {
      return ListView.builder(
        itemCount: controller.getSubjectDetailsResModel?.data?.length ?? 0,
        itemBuilder: (ctx, idx) {
          return GestureDetector(
            onTap: () {
              controller.selectedSubjectIdx.value = idx;
              Get.to(()=>NoteDetailScreen());
            },
            child: subjectCard(
              iconPath:controller.getSubjectDetailsResModel?.data?[idx].image ?? '',
              title: controller.getSubjectDetailsResModel?.data?[idx].subName ?? '',
              // subtitle: "${((controller.getSubjectDetailsResModel?.data?[idx].?.length ?? 0).toString())} Notes",
            ),
          );
        },
      );
    }
  }

  Widget subjectCard({
    required String iconPath,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: UiConstants.defaultDecoration,
      child: Row(
        children: [
          Image.network(
            iconPath,
            width: 42,
            height: 42,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  title,
                  style: UiConstants.dark_16_500,
                ),
                // Text(
                //   subtitle,
                //   style: UiConstants.secondary_10_400,
                // ),
              ],
            ),
          ),
          SvgPicture.asset(
            Assets.arrowRight,
            width: 25,
            colorFilter: const ColorFilter.mode(
                AppColors.primaryColor, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}