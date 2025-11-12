import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/modules/student/result_detail/result_detail_screen.dart';
import 'package:sheshya/theme/app_colors.dart';

class StudentResultScreen extends StatefulWidget {
  static const routeName = "/student-result";
  const StudentResultScreen({super.key});

  @override
  State<StudentResultScreen> createState() => _StudentResultScreenState();
}

class _StudentResultScreenState extends State<StudentResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Results"),
      ),
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                headerCard(),
                SizedBox(height: 21.h),
                const Text("Recent Tests", style: UiConstants.dark_12_500),
                SizedBox(height: 27.h),
                ...List.generate(
                  9,
                  (index) => GestureDetector(
                    onTap: () => Get.toNamed(ResultDetailScreen.routeName),
                    child: classTile(
                      className: "${index + 4}th",
                      section: "Sec - A",
                      topic: "TOPIC - Law of Motion",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container classTile({
    required String className,
    required String section,
    required String topic,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      height: 68.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: UiConstants.defaultDecorationBordered,
      child: Row(
        children: [
          // Image
          Container(
            width: 38.w,
            height: 26.h,
            decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(width: 2, color: AppColors.accentColor),
              borderRadius:
                  BorderRadius.circular(UiConstants.defaultRoundedCorner),
            ),
            child:
                Center(child: Text(className, style: UiConstants.light_12_500)),
          ),
          SizedBox(width: 19.w),
          // Text
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Class $className",
                  style: UiConstants.dark_14_600,
                ),
                Text(
                  section,
                  style: UiConstants.secondary_10_400,
                ),
                Text(
                  topic,
                  style: UiConstants.dark_10_400
                      .copyWith(color: AppColors.tertiaryTextColor),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          // Leading
          const Icon(
            Icons.arrow_forward_ios_outlined,
            color: AppColors.accentColor,
            size: 12,
          ),
        ],
      ),
    );
  }

  Container headerCard() {
    return Container(
      height: 77.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: UiConstants.defaultDecorationBordered,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Get subject wise result ',
                  style: UiConstants.light_12_600
                      .copyWith(color: AppColors.accentColor),
                ),
                const TextSpan(
                  text: 'of all your \nassesment.',
                  style: UiConstants.secondary_12_400,
                ),
              ],
            ),
          ),
          // Image
          SvgPicture.asset(
            AssetsConstants.studentCorner,
          )
        ],
      ),
    );
  }
}
