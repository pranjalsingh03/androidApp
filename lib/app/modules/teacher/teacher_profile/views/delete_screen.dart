import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sheshya/app/data/api/api_constants.dart';
import 'package:sheshya/app/modules/auth/views/onboarding_view.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/prefs_service.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';

class DeleteScreen extends StatelessWidget {
  final String userType; // 'student' or 'teacher'

  const DeleteScreen({super.key, required this.userType});

  Future<void> deleteUser() async {
    String endpoint = userType == 'student' ? '/student/deleteStudent' : '/teacher/deleteTeacher';
    try {
      var res = await http.delete(Uri.parse('${ApiConstants.apiBaseUrlNew}$endpoint'), headers: {
        'Authorization': 'Bearer ${PrefsService.getToken()}',
      });
      if (res.statusCode == 200) {
        showCustomSnackBar("${userType.capitalizeFirst} deleted successfully", type: SnackBarType.success);
        PrefsService.clearAll();
        Get.offAll(() => const OnboardingView());
      } else {
        showCustomSnackBar("${userType.capitalizeFirst} deletion failed");
      }
    } catch (e) {
      showCustomSnackBar("Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: Text("Delete ${userType.capitalizeFirst}"),
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
              Assets.aiIcon,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              width: 225.w,
              height: 225.w,
            ),
            const Spacer(),
            Text(
              "Are you sure you want to delete the ${userType}?",
              style: kDark_14_700,
            ),
            kdefaultYGap,
            CustomButton(
              buttonText: "Delete",
              color: AppColors.secondaryColor,
              foregroundColor: AppColors.inverseTextColor,
              onPressed: () {
                deleteUser();
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