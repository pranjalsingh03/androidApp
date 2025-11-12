import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/app/modules/parent/academic/academic_exam_controller.dart';
import 'package:flutter/material.dart';
import '../../../../components/app_bar_back_button.dart';
import 'academic_subject_screen.dart';

class AcademicExamsScreen extends GetView<AcademicExamController> {
  @override
  Widget build(BuildContext context) {
    Get.put(AcademicExamController());

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text('Academic Exams'),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: Obx(() => buildBody(context)),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    if (controller.isGetExamsLoading.value.isLoading) {
      return Center(
        child: Loader(
          text: "Loading Academic Exams",
        ),
      );
    } else if (controller.isGetExamsLoading.value.isError) {
      return Center(
        child: GestureDetector(
          onTap: () {
            controller.loadExams();
          },
          child: Text('No Exams Available.'),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: AppColors.strokeColor)),
            child: Row(
              children: [
                Image.asset(
                  AssetsConstants.examIcon,
                  fit: BoxFit.cover,
                  width: 45,
                  height: 45,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        (controller.getExamsResModel?.data?.totalExams ?? 0)
                            .toString(),
                        style: UiConstants.dark_18_700,
                      ),
                      Text(
                        "Exams",
                        style: UiConstants.secondary_10_400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Recent Exams",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.getExamsResModel?.data?.exams?.length ?? 0,
              itemBuilder: (context, index) {
                final exam = controller.getExamsResModel?.data?.exams?[index];
                return GestureDetector(
                  onTap: () {
                    controller.selectedExamId.value = exam?.sId ?? '';

                    controller.loadSubjects();

                    Get.to(AcademicSubjectScreen());
                  },
                  child: chatListTile(
                    iconPath: AssetsConstants.userAvatar,
                    title: exam?.examName ?? '',
                    subtitle: formatDate(exam?.date ?? ''),
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  String formatDate(String dateString) {
    if (dateString.isEmpty) return '';
    // Parse the string into a DateTime object
    DateTime parsedDate = DateTime.parse(dateString);

    // Define the desired format
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    // Format the parsed date
    return dateFormat.format(parsedDate).toUpperCase(); // Make it uppercase as required
  }

  Widget chatListTile({
    required String iconPath,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 0.1, color: AppColors.strokeColor)),
      child: Row(
        children: [
          Image.asset(
            AssetsConstants.examIcon,
            width: 45,
            height: 45,
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
            width: 28,
            colorFilter: const ColorFilter.mode(
                AppColors.primaryColor, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}