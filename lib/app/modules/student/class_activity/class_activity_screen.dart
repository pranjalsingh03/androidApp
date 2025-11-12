import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/custom_app_bar.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';

class ClassActivityScreen extends StatefulWidget {
  static const routeName = "/student-class-activity";
  const ClassActivityScreen({super.key});

  @override
  State<ClassActivityScreen> createState() => _ClassActivityScreenState();
}

class _ClassActivityScreenState extends State<ClassActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const CustomAppBar(title: "Class Activity"),
              // Date Range
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: UiConstants.defaultPadding,
                ),
                child: dateRange(),
              ),
              SizedBox(height: 24.h),
              // Day Cards
              dayLists(),
              SizedBox(height: 44.h),
              assignmentList(),
              SizedBox(height: 16.h),
              Container(
                width: Get.width,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                decoration: UiConstants.defaultDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Physics  |  Sangeeta Sharma",
                        style: UiConstants.dark_16_500),
                    SizedBox(height: 4.h),
                    const Text("Topics Covered",
                        style: UiConstants.secondary_12_500),
                    SizedBox(height: 4.h),
                    const Text(
                      "• Lens Diagram\n• Spherical Lense",
                      style: UiConstants.secondary_12_400,
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    actionCard(
                        title: "View\nAssignment",
                        dialogContent: "No Assignment Assigned"),
                    SizedBox(width: 16.w),
                    actionCard(
                        title: "View Tests", dialogContent: "No Test Assigned"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded actionCard({required String title, required String dialogContent}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Get.defaultDialog(
          titleStyle: UiConstants.dark_16_500.copyWith(fontSize: 20.sp),
          radius: UiConstants.defaultRoundedCorner,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
          title: "Yay!",
          content: Text(
            dialogContent,
            style: UiConstants.secondary_18_500,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          height: 60.h,
          decoration: UiConstants.defaultDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title, style: UiConstants.dark_12_500),
              const Icon(CupertinoIcons.chevron_right, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView assignmentList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          10,
          (index) => assignmentListCard(index, isSelected: index == 3),
        ),
      ),
    );
  }

  Container assignmentListCard(int index, {bool isSelected = false}) {
    return Container(
      width: 36.w,
      height: 53.h,
      margin: EdgeInsets.only(right: 14, left: index == 0 ? 16 : 0),
      decoration: isSelected
          ? ShapeDecoration(
              color: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(UiConstants.defaultRoundedCorner),
              ),
              )
          : UiConstants.defaultDecoration,
      child: Center(
        child: Text(
          "P${index + 1}",
          style: isSelected
              ? UiConstants.light_14_500
                  .copyWith(color: AppColors.inverseTextColor)
              : UiConstants.dark_14_500,
        ),
      ),
    );
  }

  SingleChildScrollView dayLists() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          dayCard(
            dayCode: "Mon",
            day: 15,
            bgColor: AppColors.secondaryColor,
            isFirst: true,
          ),
          dayCard(dayCode: "Tue", day: 16, bgColor: AppColors.secondaryColor),
          dayCard(dayCode: "Wed", day: 17, bgColor: AppColors.accentColor),
          dayCard(
            dayCode: "Thu",
            day: 18,
          ),
          dayCard(dayCode: "Fri", day: 19),
          dayCard(dayCode: "Sat", day: 20),
          dayCard(dayCode: "Sun", day: 21),
        ],
      ),
    );
  }

  Row dateRange() {
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "March",
              style: UiConstants.dark_16_500,
            ),
            const SizedBox(width: 9),
            SvgPicture.asset(
              AssetsConstants.arrowDown,
              width: 18,
              height: 18,
            ),
          ],
        ),
        const Spacer(),
        Icon(CupertinoIcons.chevron_left, size: 16.w),
        const SizedBox(width: 11),
        Icon(CupertinoIcons.chevron_right, size: 16.w),
      ],
    );
  }

  Container dayCard({
    required String dayCode,
    required int day,
    Color bgColor = Colors.white,
    bool isFirst = false,
  }) {
    return Container(
      width: 48.w,
      height: 75.h,
      margin: EdgeInsets.only(right: 14, left: isFirst ? 16 : 0),
      padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 9),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: bgColor == Colors.white ? 1 : 0,
              color: AppColors.cardBorderColor),
          borderRadius: BorderRadius.circular(UiConstants.defaultRoundedCorner),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dayCode,
            style: bgColor == AppColors.accentColor
                ? UiConstants.light_14_700
                : UiConstants.dark_14_700,
          ),
          Text(
            day.toString(),
            style: bgColor == AppColors.accentColor
                ? UiConstants.light_18_700
                : UiConstants.dark_18_700,
          )
        ],
      ),
    );
  }
}
