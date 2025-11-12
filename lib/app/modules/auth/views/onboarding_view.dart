import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/user_type.dart';
import 'package:sheshya/app/modules/auth/controllers/auth_controller.dart';
import 'package:sheshya/app/routes/app_pages.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/components/text_header_widget.dart';
import 'package:sheshya/constants/app_constants.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  void navigateToLoginScreen(UserType userType) {
    AuthController controller = Get.find<AuthController>();
    controller.setUserType(userType);
    Get.toNamed(Routes.LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
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
                kdefaultYGap,
                // Tag Line
                Text(
                  AppConstants.tagLine,
                  textAlign: TextAlign.center,
                  style: kDark_18_600,
                ),

                kdefaultYGap,
              // Continue as Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                    children: [
                      const TextHeaderWidget(text: "Continue as"),

                    SizedBox(height: 16.h),
                    kdefaultYGap,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      // Educator Button
                      GestureDetector(
                        onTap: () => navigateToLoginScreen(UserType.teacher),
                        child: Container(
                        height: 210,
                        width: Get.width * 0.4,
                        padding: EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFBF5A),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                          Text("Educator", style: TextStyle(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.w500)),  
                          SizedBox(height: 8.h),
                          SvgPicture.asset(Assets.teacherLogin, height: 100.h),
                          ],
                        ),
                        ),
                      ),
                      SizedBox(width: 16.w),

                      // Parent & Student Button
                      GestureDetector(
                        onTap: () => navigateToLoginScreen(UserType.parent),
                        child: Container(
                        height: 210,
                        width: Get.width * 0.4,
                        padding: EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFFD972FF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                          Text("Student", style: TextStyle(fontSize: 14.sp,color: Colors.white,fontWeight: FontWeight.w500)),
                          SizedBox(height: 8.h),
                          SvgPicture.asset(Assets.parentLogin, height: 115.h),
                          ],
                        ),
                        ),
                      ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Footer (Terms & Privacy)
              RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: kDark_10_400,
                        children: [
                          const TextSpan(
                              text: "By continuing, you agree to our\n"),
                          TextSpan(
                            text: "Terms of Service",
                            style: kDark_10_400.copyWith(
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showCustomSnackBar("Terms of Service",
                                    type: SnackBarType.info);
                              },
                          ),
                          const TextSpan(text: " , "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: kDark_10_400.copyWith(
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showCustomSnackBar("Privacy Policy",
                                    type: SnackBarType.info);
                              },
                          ),
                          const TextSpan(text: " & "),
                          TextSpan(
                            text: "Content Policy",
                            style: kDark_10_400.copyWith(
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showCustomSnackBar("Content Policy",
                                    type: SnackBarType.info);
                              },
                          ),
                        ],
                      ),
                    ),
                    k12YGap
            ],
          ),
        ),
      ),
    ),
      );
  }
}
