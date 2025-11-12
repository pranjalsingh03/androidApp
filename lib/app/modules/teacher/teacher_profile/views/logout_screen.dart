import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/auth/views/onboarding_view.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/prefs_service.dart';
import 'package:sheshya/theme/app_colors.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text("Logout"),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              Assets.logout,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              width: 225.w,
              height: 225.w,
            ),
            const Spacer(),
            Text(
              "Are you sure you want to logout?",
              style: kDark_14_700,
            ),
            kdefaultYGap,
            CustomButton(
              buttonText: "Logout",
              color: AppColors.secondaryColor,
              foregroundColor: AppColors.inverseTextColor,
              onPressed: () {
                PrefsService.clearAll();
                Get.offAll(() => const OnboardingView());
              },
            ),
            kdefaultYGap,
            CustomButton(
              buttonText: "Cancel",
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
