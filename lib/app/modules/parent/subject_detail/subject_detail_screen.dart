import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/data/const_data/subjects_data.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/assets.dart';

class SubjectDetailScreen extends StatefulWidget {
  static const routeName = "/subject-detail";
  const SubjectDetailScreen({super.key});

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('English'), leading: const AppBarBackButton()),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width - 32,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                decoration: UiConstants.defaultDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Score",
                      style: UiConstants.secondary_10_500,
                    ),
                    Text(
                      "85.75%",
                      style: UiConstants.dark_18_600
                          .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Image.asset(AssetsConstants.lineGraph),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.dividercolor),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "View Statistics",
                            style: UiConstants.dark_14_600,
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.arrowRight,
                          width: 8,
                          colorFilter: const ColorFilter.mode(
                              AppColors.primaryColor, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  reportTile(name: "Average", value: "84.5%"),
                  reportTile(name: "Highest", value: "95 Marks"),
                  reportTile(name: "Exams ", value: "4"),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                "Recent English Exams",
                style: UiConstants.dark_16_600,
              ),
              const SizedBox(height: 22),
              ...examsData.map((subject) {
                return subjectCard(
                  iconPath: subject['iconPath'].toString(),
                  title: subject['title'].toString(),
                  subtitle: subject['subtitle'].toString(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget reportTile({required String value, required String name}) {
    return Container(
      width: 96,
      padding: const EdgeInsets.all(16),
      decoration: UiConstants.defaultDecoration,
      child: Column(
        children: [
          SvgPicture.asset(AssetsConstants.office),
          const SizedBox(height: 16),
          Text(
            value,
            style: UiConstants.dark_12_600,
          ),
          const SizedBox(height: 9),
          Text(
            name,
            style: UiConstants.secondary_12_400,
          ),
        ],
      ),
    );
  }

  Widget subjectCard({
    required String iconPath,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: () => Get.toNamed(SubjectDetailScreen.routeName),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: UiConstants.defaultDecoration,
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 42,
              height: 42,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: UiConstants.dark_14_500,
                  ),
                  Text(
                    subtitle,
                    style: UiConstants.secondary_10_400,
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              Assets.arrowRight,
              width: 8,
              colorFilter: const ColorFilter.mode(
                  AppColors.primaryColor, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
