import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/data/const_data/exam_tile.dart';
import 'package:sheshya/theme/app_colors.dart';

class UpcomingExamScreen extends StatefulWidget {
  static const routeName = "/upcoming-exam";
  const UpcomingExamScreen({super.key});

  @override
  State<UpcomingExamScreen> createState() => _UpcomingExamScreenState();
}

class _UpcomingExamScreenState extends State<UpcomingExamScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Upcoming Exams"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 16.h),
                examsTiles(),
                SizedBox(height: 16.h),
                ...List.generate(
                  10,
                  (index) => assignmentCard(
                    image: examData[selectedIndex].bgImage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container assignmentCard({required String image}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(UiConstants.defaultRoundedCorner),
          ),),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(UiConstants.defaultRoundedCorner),
                topRight: Radius.circular(UiConstants.defaultRoundedCorner)),
            child: SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${examData[selectedIndex].title} Name",
                    style: UiConstants.dark_14_500),
                const Text("Description", style: UiConstants.secondary_12_500),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(
                            UiConstants.defaultRoundedCorner),
                      ),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.verified,
                            color: AppColors.whiteColor,
                            size: 12.w,
                          ),
                          SizedBox(width: 6.w),
                          const Text(
                            "₹ 1000",
                            style: UiConstants.light_10_400,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    const Text("2200 Registered",
                        style: UiConstants.dark_10_400),
                    SizedBox(width: 12.w),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.alarm,
                          size: 13.w,
                        ),
                        SizedBox(width: 6.w),
                        const Text("19 days left",
                            style: UiConstants.dark_10_400),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: UiConstants.defaultDecorationBordered,
                      child: const Text("Computer",
                          style: UiConstants.secondary_10_500),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: UiConstants.defaultDecorationBordered,
                      child: const Text("Marketting",
                          style: UiConstants.secondary_10_500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: examData[selectedIndex].activeColor,
            ),
            onPressed: () {},
            child: const Text("Register"),
          )
        ],
      ),
    );
  }

  SingleChildScrollView examsTiles() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: examData
            .map((e) => examCard(
                  title: e.title,
                  count: e.count,
                  image: e.tileImage,
                  activeColor: e.activeColor,
                  isSelected: selectedIndex == examData.indexOf(e),
                  isLast: examData.indexOf(e) == examData.length - 1,
                ))
            .toList(),
      ),
    );
  }

  Widget examCard({
    required String title,
    required String count,
    required String image,
    required Color activeColor,
    bool isSelected = false,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex =
              examData.indexOf(examData.firstWhere((e) => e.title == title));
        });
      },
      child: Container(
        height: 180.h,
        margin: EdgeInsets.only(right: isLast ? 0 : 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: ShapeDecoration(
          color: isSelected ? activeColor : AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(UiConstants.defaultRoundedCorner),
          ),
          shadows: UiConstants.defaultBoxShadows,
        ),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              height: 69.h,
              child: SvgPicture.asset(image),
            ),
            const Spacer(),
            Text(title,
                textAlign: TextAlign.center, style: UiConstants.light_14_600),
            Text(
              count,
              style: UiConstants.light_14_400,
            ),
          ],
        ),
      ),
    );
  }
}
