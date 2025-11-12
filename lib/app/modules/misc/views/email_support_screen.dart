import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/parent/parent_home/parent_home_screen.dart';
import 'package:sheshya/app/modules/splash/controllers/splash_controller.dart';
import 'package:sheshya/app/modules/student/dashboard/student_dashboard_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/helper/system_ui.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailSupportScreen extends StatelessWidget {
  const EmailSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUi.defaultStyle,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text("Email Support"),
        ),
        body: Container(
          padding: const EdgeInsets.all(Dimensions.defaultPadding),
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Write us an issue you are facing on",
                style: kDark_18_500,
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    await launchUrl(
                        Uri.parse("mailto:sheshyasupport@sheshya.in"));
                  } catch (e) {
                    showCustomSnackBar(
                        'Unable to open email app\nTry sending email manually.');
                  }
                },
                child: Text(
                  "sheshyasupport@sheshya.in",
                  style: kDark_18_500.copyWith(
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(Dimensions.defaultPadding),
          // child: CustomButton(
          //   buttonText: "Back to Homepage",
          //   onPressed: () => Get.to(StudentDashboardScreen()),
          // ),
        ),
      ),
    );
  }
}
