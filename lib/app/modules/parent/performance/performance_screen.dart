import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/app/data/const_data/subjects_data.dart';
import 'package:sheshya/app/modules/parent/subject_detail/subject_detail_screen.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/assets.dart';

class PerformanceScreen extends StatefulWidget {
  static const routeName = "/performace";
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Performance'), leading: const AppBarBackButton()),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              profileDetailCard(),
              const SizedBox(height: 16),
              // Search
              searchBar(),
              const SizedBox(height: 30),
              // Subject
              subjects(),
            ],
          ),
        ),
      ),
    );
  }

  Widget subjects() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Subject Overview",
          style: UiConstants.dark_16_600,
        ),
        const SizedBox(height: 12),
        ...subjectData.map((subject) {
          return subjectCard(
            iconPath: subject['iconPath'].toString(),
            title: subject['title'].toString(),
            subtitle: subject['subtitle'].toString(),
          );
        }),
      ],
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

  Container searchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: UiConstants.defaultDecorationBordered,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(AssetsConstants.search),
          const SizedBox(width: 15),
          const Text(
            "Search",
            style: UiConstants.dark_14_400,
          )
        ],
      ),
    );
  }

  Widget profileDetailCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DottedBorder(
              borderType: BorderType.Circle,
              strokeWidth: 2,
              dashPattern: const [10],
              strokeCap: StrokeCap.round,
              color: AppColors.primaryColor.withOpacity(.1),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Image.asset(
                  AssetsConstants.userAvatar,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                ),
              )),
          // Bio
          const Text(
            "Arav Anand",
            style: UiConstants.dark_18_600,
          ),
          const Text(
            "Class 8th",
            style: UiConstants.secondary_12_400,
          ),
        ],
      ),
    );
  }
}
