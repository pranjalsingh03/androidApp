import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/primary_button.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/modules/parent/behaviour_report/behaviour_report_screen.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/modules/parent/activity/activity_controller.dart';

import '../../../../helper/class_helper.dart';
import '../chatbox/get_all_teachers_res_model.dart';
import '../parent_home/parent_home_controller.dart';

//
// class ActivityScreen extends StatefulWidget {
//   static const routeName = "/parent-activity";
//   const ActivityScreen({super.key});
//
//   @override
//   State<ActivityScreen> createState() => _ActivityScreenState();
// }

class ActivityScreen extends GetView<ActivityController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ActivityController());

    final ParentHomeController parentHomeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Today's Activity"),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(16),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                studentDetailCard(parentHomeController),
                const SizedBox(height: 26),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Avatar
                        Obx(() => studentStatus()),

                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => Get.to(BehaviourReportScreen()),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: ShapeDecoration(
                              color: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Behaviour Report",
                                  style: lightsemibold14.copyWith(
                                      color: AppColors.whiteColor),
                                ),
                                SvgPicture.asset(
                                    AssetsConstants.behaviourReport),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(() => buildClassList()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Container(
            //   padding: const EdgeInsets.only(top: 8),
            //   color: AppColors.backgroundColor,
            //   child: PrimaryButton(
            //       text: "Return to homepage", press: () => Get.back()),
            // ),
          ],
        ),
      ),
    );
  }

  Container dailyClassCard(int index, String subName, String period,
      String teacherName, String desc) {
    return Container(
      width: Get.width - 32,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: AppColors.cardBorderColor,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                subName,
                style: darksemibold16,
              ),
              Text(
                "Period ${period}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${desc}",
                style: lightnormal16,
              ),
              Text(
                teacherName,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget studentDetailCard(ParentHomeController parentHomeController) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(16),
              child: DottedBorder(
                  borderType: BorderType.Circle,
                  strokeWidth: 2,
                  dashPattern: const [10],
                  strokeCap: StrokeCap.round,
                  color: AppColors.primaryColor.withOpacity(.1),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Image.asset(
                      AssetsConstants.userAvatar,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  )),
            ),
          ),
          // Bio
          Text(
            parentHomeController?.studentProfileResModel?.data?.basic?.name ??
                '--',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              fontFamily: kFontFamily,
              color: AppColors.textColor,
            ),
          ),
          Text(
            "Class ${(parentHomeController?.studentProfileResModel?.data?.academic?.className ?? '')} - Section ${(parentHomeController?.studentProfileResModel?.data?.academic?.section ?? '')}",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                fontFamily: kFontFamily,
                color: AppColors.secondaryTextColor),
          ),
        ],
      ),
    );
  }

  Widget studentStatus() {
    if (controller.isGetTodayAttendanceLoading.value.isLoading) {
      return const Column(
        children: [
          SizedBox(height: 20),
          CircularProgressIndicator(),
          SizedBox(height: 20),
        ],
      );
    } else if (controller.isGetTodayAttendanceLoading.value.isError) {
      return Column(
        children: [
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              controller.loadTodayAttendance();
            },
            child: Text(
              'Retry',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      );
    } else {
      // Check if success is false
      bool isSuccess = controller.getTodayAttendanceResModel?.success ?? false;
      bool isPresent = ((controller?.getTodayAttendanceResModel?.status ?? '')
              .toString()
              .toLowerCase() ==
          'present');

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: AppColors.cardBorderColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('yyyy-MM-dd').format(DateTime.now()),
              style: TextStyle(
                color: Color(0xFF83898F),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            // ProgressBar
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 6,
                ),
                Expanded(
                  child: Divider(
                    color: isSuccess && isPresent
                        ? AppColors.primaryColor
                        : AppColors.disabledColor,
                    thickness: 3,
                  ),
                ),
                if (isSuccess && isPresent)
                  CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 6,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            // Status
            GridView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 22,
              ),
              children: [
                Text(
                  "School",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                Text(
                  "Attendance",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                Text(
                  isSuccess
                      ? (isPresent ? "Reached" : "Not Reached")
                      : "Not Reached",
                  style: darksemibold14,
                ),
                Text(
                  isSuccess
                      ? (isPresent ? "Present" : "Absent")
                      : "Not Reached",
                  style: darksemibold14,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget buildClassList() {
    if (controller.isActivityLoading.value.isLoading) {
      return const Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          )
        ],
      );
    } else if (controller.isActivityLoading.value.isError) {
      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () {
                controller.loadTodayAttendance();
              },
              child: Text(
                'Retry',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 18),
              )),
          SizedBox(
            height: 20,
          )
        ],
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: (controller.getActivityResModel?.data?.length ?? 0),
        separatorBuilder: (ctx, idx) {
          return SizedBox(
            height: 10,
          );
        },
        itemBuilder: (ctx, index) {
          String subName =
              controller.getActivityResModel?.data?[index]?.subjectName ?? '';
          String desc =
              controller.getActivityResModel?.data?[index]?.description ?? '';
          String period =
              controller.getActivityResModel?.data?[index]?.periodNumber ?? '';
          String teacherName =
              controller.getActivityResModel?.data?[index]?.teacherName ?? '';

          return dailyClassCard(index, subName, period, teacherName, desc);
        },
      );
    }
  }
}
