import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/misc/views/email_support_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/system_ui.dart';
import 'package:sheshya/theme/app_colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUi.defaultStyle,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text('Support'),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: const EdgeInsets.all(Dimensions.defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                settingTile(
                  title: "Chat with us",
                  onTap: () => Get.to(() => const EmailSupportScreen()),
                ),
                settingTile(
                  title: "Send us an Email",
                  onTap: () => Get.to(() => const EmailSupportScreen()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget settingTile({required String title, required VoidCallback onTap}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(Dimensions.defaultPadding),
    decoration: kDefaultDecoration,
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: kDark_14_500,
            ),
          ),
          SvgPicture.asset(
            Assets.arrowRight,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    ),
  );
}
