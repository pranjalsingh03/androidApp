import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/user_type.dart';
import 'package:sheshya/app/modules/auth/controllers/auth_controller.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/components/text_header_widget.dart';
import 'package:sheshya/constants/app_constants.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/extensions_helper.dart';
import 'package:sheshya/app/data/model/login_type.dart';
import 'package:sheshya/theme/app_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            // statusBarColor: AppColors.primaryColor,
            // systemNavigationBarColor: AppColors.backgroundColor,
            // systemNavigationBarIconBrightness: Brightness.dark,
            ),
        child: GetBuilder<AuthController>(
          builder: (authController) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: 330.h,
                      child: Image.asset(
                      authController.userType == UserType.teacher
                        ? Assets.loginImage
                        : Assets.otpVerify,
                      fit: BoxFit.cover,
                      ),
                    ),
                    kdefaultYGap,
                    // Tag Line
                    Text(
                      AppConstants.tagLine,
                      style: kDark_18_600,
                      textAlign: TextAlign.center,
                    ),
                    k20YGap,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextHeaderWidget(
                          text:
                              "${authController.userType == UserType.parent ? "Parent" : "Teacher"} Login"
                                  .toTitleCase()),
                    ),
                    kdefaultYGap,
                    // Phone Number Input
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.defaultPadding.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: 56.w,
                            height: 48.h,
                            padding: EdgeInsets.all(10.w),
                            decoration: kDefaultDecorationBordered,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.defaultRoundedCorner),
                              child: Image.asset(
                                Assets.indianFlag,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          k12XGap,
                          Expanded(
                            child: SizedBox(
                              height: 48.h,
                              child: authController.loginType == LoginType.phone
                                  ?
                                  // Phone Number Input
                                  TextField(
                                      onChanged: (value) => authController
                                          .validatePhoneNumber(value.trim()),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      controller:
                                          authController.phoneNumberController,
                                      keyboardType: TextInputType.number,
                                      onTapOutside: (event) =>
                                          FocusScope.of(context).unfocus(),
                                      cursorColor: AppColors.primaryColor,
                                      style: kDark_14_400,
                                      decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.h, horizontal: 10.w),
                                          child:
                                              Text("+91", style: kDark_14_400),
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                                minWidth: 0, minHeight: 0),
                                        hintText: "Enter Phone Number",
                                        hintStyle: kSecondary_14_400,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.h, horizontal: 10.w),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: AppColors.strokeColor),
                                        ),
                                      ),
                                    )
                                  // Email Input
                                  : TextField(
                                      onChanged: (value) =>
                                          authController.validateEmail(value),
                                      controller:
                                          authController.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      onTapOutside: (event) =>
                                          FocusScope.of(context).unfocus(),
                                      cursorColor: AppColors.primaryColor,
                                      style: kDark_14_400,
                                      decoration: InputDecoration(
                                        hintText: "Enter Email Address",
                                        hintStyle: kSecondary_14_400,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.h, horizontal: 10.w),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: AppColors.strokeColor),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    kdefaultYGap,
                    authController.isSendingOtp
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            buttonText: "Continue",
                            onPressed: authController.isPhoneNumberValid ||
                                    authController.isEmailValid
                                ? () => authController.sendOtp()
                                : null,
                          ),
                    k20YGap,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const TextHeaderWidget(text: "OR"),
                    ),
                    k20YGap,
                    Container(
                      width: 500,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: authController.userType == UserType.teacher
                            ? const Color(0xFFFFBF5A) 
                            : const Color(0xFFD972FF),
                        border: Border.all(
                            color: AppColors.strokeColor, width: 1.w),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GestureDetector(
                      onTap: () {
                        authController.toggleLoginType();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                          // border: Border.all(
                          //   color: AppColors.strokeColor, width: 1.w),
                          // borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: SvgPicture.asset(
                          authController.loginType == LoginType.email
                            ? Assets.phone
                            : Assets.email,

                            // fit: BoxFit.fitWidth,
                            // height: 5.h,
                          ),
                        ),
                        SizedBox(width: 8.w), // Space between logo and text
                        Text(
                          authController.loginType == LoginType.email
                            ? "Continue with your Phone"
                            : "Continue with your Email",
                          style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                          ),
                        ),
                        ],
                      ),
                      ),
                    ),
                    const Spacer(),
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
                    k12YGap,
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
