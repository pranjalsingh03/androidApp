import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';

class SubjectSelectionScreen extends StatefulWidget {
  static const routeName = "/ai-tutor/subject-selection";
  const SubjectSelectionScreen({super.key});

  @override
  State<SubjectSelectionScreen> createState() => _SubjectSelectionScreenState();
}

class _SubjectSelectionScreenState extends State<SubjectSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("AI Tutor"),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor,
                foregroundColor: AppColors.textColor,
                minimumSize: Size(double.infinity, 48.h),
                
                shape: RoundedRectangleBorder(
                  side:
                      const BorderSide(width: 1, color: AppColors.strokeColor),
                  borderRadius:
                      BorderRadius.circular(UiConstants.defaultRoundedCorner),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Select Subject",
                style: UiConstants.dark_16_600,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
              ),
              onPressed: () {},
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
