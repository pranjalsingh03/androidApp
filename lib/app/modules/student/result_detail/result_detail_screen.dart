import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';

class ResultDetailScreen extends StatefulWidget {
  static const routeName = "/result-detail";
  const ResultDetailScreen({super.key});

  @override
  State<ResultDetailScreen> createState() => _ResultDetailScreenState();
}

class _ResultDetailScreenState extends State<ResultDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Midterm Exam"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              statsChart(),
              SizedBox(height: 20.h),
              const Text(
                "Weakness",
                style: UiConstants.dark_16_500,
              ),
              SizedBox(height: 15.h),
              Container(
                height: 73.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: UiConstants.defaultDecoration,
                child: const Text(
                  "Need to Improvement",
                  style: UiConstants.secondary_14_400,
                ),
              ),
              SizedBox(height: 20.h),
              const Text(
                "Suggested Videos ",
                style: UiConstants.dark_16_500,
              ),
              SizedBox(height: 15.h),
              Container(
                height: 73.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: UiConstants.defaultDecoration,
                child: const Text(
                  "Link of those videos",
                  style: UiConstants.secondary_14_400,
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Back to Homepage"))
            ],
          ),
        ),
      ),
    );
  }

  Container statsChart() {
    return Container(
      decoration: UiConstants.defaultDecoration,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          recordTileHeader(),
          const SizedBox(height: 28),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(AssetsConstants.pieChart),
                Column(
                  children: [
                    Text(
                      "65%",
                      style: UiConstants.dark_10_700.copyWith(fontSize: 30),
                    ),
                    const Text(
                      "Ahead of Class",
                      style: UiConstants.secondary_12_400,
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          recordTotalStats(),
        ],
      ),
    );
  }

  Widget recordTileHeader() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Statistics",
          style: UiConstants.secondary_8_500,
        ),
        SizedBox(height: 4),
        Text(
          "Exam 1",
          style: UiConstants.dark_10_500,
        )
      ],
    );
  }

  Column recordTotalStats() {
    return Column(
      children: [
        recordCardTitle(
            bgColor: AppColors.primaryColor,
            text: "Right Answers",
            value: "410"),
        recordCardTitle(
            bgColor: AppColors.primaryLowVersionColor,
            text: "Wrong Answers",
            value: "340"),
        recordCardTitle(
            bgColor: AppColors.accentColor,
            text: "Not Attempted",
            value: "142"),
      ],
    );
  }

  Row recordCardTitle({
    required Color bgColor,
    required String text,
    required String value,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 7,
          backgroundColor: bgColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: UiConstants.dark_16_600,
          ),
        ),
        Text(
          value,
          style: UiConstants.secondary_16_500,
        )
      ],
    );
  }
}
