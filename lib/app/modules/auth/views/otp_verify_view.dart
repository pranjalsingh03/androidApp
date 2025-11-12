import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sheshya/app/data/model/login_type.dart';
import 'package:sheshya/app/modules/auth/controllers/auth_controller.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/inline_button.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class OtpVerifyView extends StatefulWidget {
  const OtpVerifyView({super.key});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
  final pinputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    pinputFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) => Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text("Enter Your Code"),
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(Dimensions.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "We sent an email with a 6-digit code to",
                textAlign: TextAlign.center,
                style: kSecondary_12_400,
              ),
              Text(
                authController.loginType == LoginType.phone
                    ? authController.phoneNumber
                    : authController.email,
                style: kDark_12_500,
              ),
              SizedBox(height: 24.h),
              Pinput(
                length: 6,
                controller: authController.otpController,
                focusNode: pinputFocusNode,
                onChanged: (value) => authController.validateOtp(value),
                onCompleted: (pin) {
                  pinputFocusNode.unfocus();
                  authController.verifyOtp();
                },
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              ),
              SizedBox(height: 32.h),
              authController.isVerifyingOtp
                  ? const CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    )
                  : CustomButton(
                      buttonText: "Continue",
                      onPressed: authController.isOtpValid
                          ? () => authController.verifyOtp()
                          : null,
                    ),
              k20YGap,
              InlineIconButton(
                onTap: () => authController.sendOtp(),
                text: "Resend SMS",
                icon: CupertinoIcons.chat_bubble_text,
              ),
              k16YGap,
              authController.loginType == LoginType.phone
                  ? InlineIconButton(
                      onTap: () => Get.back(),
                      text: "Edit Phone Number",
                      icon: CupertinoIcons.phone,
                    )
                  : InlineIconButton(
                      onTap: () => Get.back(),
                      text: "Edit Email Id",
                      icon: CupertinoIcons.mail,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
