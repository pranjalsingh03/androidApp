import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/data/const_data/filters.dart';
import 'package:sheshya/theme/app_colors.dart';

class AssignmentTestScreen extends StatefulWidget {
  final String subjectName;
  static const routeName = "/assignment-test";
  const AssignmentTestScreen({super.key, required this.subjectName});

  @override
  State<AssignmentTestScreen> createState() => _AssignmentTestScreenState();
}

class _AssignmentTestScreenState extends State<AssignmentTestScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  String selectedFilter = "All";

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: Text(widget.subjectName),
        bottom: TabBar(
          controller: tabController,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          tabs: const [
            Tab(text: 'Assignments'),
            Tab(text: 'Tests'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          assignments(),
          tests(),
        ],
      ),
    );
  }

  SingleChildScrollView filters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          filtersData.length,
          (index) => Container(
            margin: EdgeInsets.only(
              right: index == filtersData.length - 1 ? 0 : 8.w,
            ),
            child: filterChip(
              text: filtersData[index],
              isSelected: selectedFilter == filtersData[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterChip({required String text, required bool isSelected}) {
    return GestureDetector(
      onTap: () => setState(() {
        selectedFilter = text;
      }),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: ShapeDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(UiConstants.defaultRoundedCorner),
          ),
        ),
        child: Text(
          text,
          style:
              isSelected ? UiConstants.light_14_600 : UiConstants.dark_14_500,
        ),
      ),
    );
  }

  Container assignments() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      height: Get.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            filters(),
            SizedBox(height: 16.h),
            assignmentCard(),
            assignmentCard(),
            assignmentCard(),
          ],
        ),
      ),
    );
  }

  Widget assignmentCard() {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        width: Get.width - 32.w,
        decoration: UiConstants.defaultDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(UiConstants.defaultRoundedCorner),
                topRight: Radius.circular(UiConstants.defaultRoundedCorner),
              ),
              child: Container(
                height: 137.h,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
            // assignment details
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Maths Homework",
                    style: UiConstants.dark_14_500,
                  ),
                  const Text(
                    "Linear Equation",
                    style: UiConstants.secondary_12_500,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Due Date
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 16,
                              color: AppColors.secondaryColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            const Text(
                              "16th sep 2024",
                              style: UiConstants.secondary_10_500,
                            ),
                          ],
                        ),
                      ),
                      // Teacher Name
                      // Due Date
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.person_crop_circle,
                              size: 16,
                              color: AppColors.secondaryColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            const Text(
                              "Teacher Name",
                              style: UiConstants.secondary_10_500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Due & Button
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Due: 2 Days",
                          style: UiConstants.dark_14_600.copyWith(
                            color: AppColors.inverseColor,
                          )),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container tests() {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
      height: Get.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            filters(),
            SizedBox(height: 16.h),
            testCard(),
            testCard(),
            testCard(),
          ],
        ),
      ),
    );
  }

  Widget testCard() {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        width: Get.width - 32.w,
        decoration: UiConstants.defaultDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(UiConstants.defaultRoundedCorner),
                topRight: Radius.circular(UiConstants.defaultRoundedCorner),
              ),
              child: Container(
                height: 137.h,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
            // assignment details
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Maths Homework",
                    style: UiConstants.dark_14_500,
                  ),
                  const Text(
                    "Linear Equation",
                    style: UiConstants.secondary_12_500,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Due Date
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 16,
                              color: AppColors.secondaryColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            const Text(
                              "16th sep 2024",
                              style: UiConstants.secondary_10_500,
                            ),
                          ],
                        ),
                      ),
                      // Teacher Name
                      // Due Date
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.person_crop_circle,
                              size: 16,
                              color: AppColors.secondaryColor,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            const Text(
                              "Teacher Name",
                              style: UiConstants.secondary_10_500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Due & Button
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Due: 2 Days",
                          style: UiConstants.dark_14_600.copyWith(
                            color: AppColors.inverseColor,
                          )),
                      const Icon(Icons.chevron_right)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
