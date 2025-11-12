import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/primary_button.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/data/const_data/behaviour_report.dart';
import 'package:sheshya/app/data/model/ui_models/behaviour_report_model.dart';
import 'package:sheshya/theme/app_colors.dart';

import '../../../../constants/assets_constants.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({super.key});

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.chevron_left,
            )),
        title: const Text(
          "Coming Soon",
          style: UiConstants.appBarTitle,
        ),
      ),
      body: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ...behaviourReports.map((report) => behaviourReportCard(report)),
              const Spacer(),
              SvgPicture.asset(AssetsConstants.education),
              SizedBox(height: 30,),
              Text(
                'Coming Soon',
                style: UiConstants.dark_18_700,
              ),
              const Spacer(),
              PrimaryButton(
                  text: "Return to homepage", press: () {Get.back();Get.back();}),
            ],
          )),
    );
  }

  Container behaviourReportCard(BehaviourReportModel report) {
    return Container(
      width: Get.width - 32,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                report.title,
                style: darknormal14.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                report.date,
                style: const TextStyle(
                  color: AppColors.secondaryTextColor,
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Text(
            report.submittedBy,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w400,
              color: AppColors.tertiaryTextColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            report.content,
            style: lightnormal10,
          ),
        ],
      ),
    );
  }
}
