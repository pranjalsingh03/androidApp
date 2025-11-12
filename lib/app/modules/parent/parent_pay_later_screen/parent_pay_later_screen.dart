import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/assets_constants.dart';

class ParentPayLaterScreen extends StatelessWidget {
  static const routeName = "/parent-pay-later";
  const ParentPayLaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Sheshya Payment Later'),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              size: Dimensions.defaultPadding,
            ),
          )),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsConstants.education),
            const SizedBox(height: 32),
            const Text(
              "Hold Tight!",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "We are coming!",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.primaryColor,
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
