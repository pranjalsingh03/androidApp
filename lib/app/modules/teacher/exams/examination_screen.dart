import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class ExaminationScreen extends StatelessWidget {
  const ExaminationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of exams
    final List<Map<String, String>> exams = [
      // {
      //   'title': 'Periodic Assessment 1',
      //   'marks': '20 Marks',
      //   'date': 'March 2024',
      // },
      // {
      //   'title': 'Mid - Term Examination',
      //   'marks': '80 Marks',
      //   'date': 'August 2024',
      // },
      // {
      //   'title': 'Periodic Assessment 2',
      //   'marks': '20 Marks',
      //   'date': 'October 2024',
      // },
      // {
      //   'title': 'Mid - Term Examination',
      //   'marks': '80 Marks',
      //   'date': 'February 2025',
      // },
      // {
      //   'title': 'End - Term Examination',
      //   'marks': '80 Marks',
      //   'date': 'June 2025',
      // },
      // Add more exams as needed
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: const Text('Exams'),
      ),
      body: Container(
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: exams.isEmpty
                ? [
                    Center(
                      child: Text(
                        'No exams available',
                        style: kSecondary_16_500,
                      ),
                    ),
                  ]
                : exams.map((exam) {
                    return examTileCard(
                      title: exam['title']!,
                      marks: exam['marks']!,
                      date: exam['date']!,
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }

  Container examTileCard({
    required String title,
    required String marks,
    required String date,
  }) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: const EdgeInsets.all(Dimensions.defaultPadding),
      decoration: kDefaultDecorationBordered,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kSecondary_16_500,
              ),
              Text(
                marks,
                style: kDark_10_400,
              ),
              Text(
                date,
                style: kDark_10_400.copyWith(
                  fontWeight: FontWeight.w300,
                  color: AppColors.tertiaryTextColor,
                ),
              ),
            ],
          ),

          // Arrow
          SvgPicture.asset(
            Assets.arrowRight,
            colorFilter: const ColorFilter.mode(
              AppColors.textColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}