import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';
import '../controllers/teacher_input_welcome_controller.dart';

class TeacherInputWelcomeView extends GetView<TeacherInputController> {
  const TeacherInputWelcomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.primaryColor,
        systemNavigationBarColor: AppColors.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                SizedBox(
                  width: Get.width,
                  height: 336.h,
                  child: SvgPicture.asset(
                    Assets.onboardingImage,
                    fit: BoxFit.fill,
                  ),
                ),
                k20YGap,
                // Tag Line
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome, ",
                      textAlign: TextAlign.center,
                      style: kDark_18_600.copyWith(fontSize: 24.sp),
                    ),
                    Text(
                      "",
                      textAlign: TextAlign.center,
                      style: kDark_18_600.copyWith(
                        fontSize: 24.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                k12YGap,
                // Tag Line
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'You are now part of the incredible\necosystem ',
                        style: kSecondary_14_400,
                      ),
                      TextSpan(
                        text: 'Designed',
                        style: kDark_14_400.copyWith(
                          color: AppColors.inverseColor,
                        ),
                      ),
                      TextSpan(text: ' for you.', style: kSecondary_14_400),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                CustomButton(
                  margin: const EdgeInsets.all(Dimensions.defaultPadding),
                  color: AppColors.primaryColor,
                  buttonText: 'Continue',
                  onPressed: () => {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
