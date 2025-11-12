import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/app/modules/parent/academic/academic_exam_controller.dart';
import 'package:flutter/material.dart';
import '../../../../components/app_bar_back_button.dart';
import 'academic_performance_screen.dart';


class AcademicSubjectScreen extends GetView<AcademicExamController>  {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text('Subjects'),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        child: Obx(
                ()=> buildBody(context)
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context){
    final size = MediaQuery.sizeOf(context);
    if(controller.isGetSubjectsLoading.value.isLoading){
      return Column(
        children: [
          CircularProgressIndicator(),
        ],
      );
    }
    else if( controller.isGetSubjectsLoading.value.isError){
      return GestureDetector(
          onTap: (){
            controller.loadSubjects();
          },
          child: Text('retry')
      );
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              itemCount: controller.getSubjectsResModel?.data?.subjects?.length ?? 0,
              itemBuilder: (context, index) {
                final subject = controller.getSubjectsResModel?.data?.subjects?[index];
                return GestureDetector(
                  onTap: (){
                    controller.selectedSubjectId.value = subject?.id ?? '';
                    controller.selectedSubjectName.value = subject?.name ?? '';

                    controller.loadAcademicPerformance();

                    Get.to(AcademicPerformanceScreen());
                  },
                  child: chatListTile(
                    iconPath: AssetsConstants.userAvatar,
                    title: subject?.name ?? '',
                    subtitle: ''
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
    if(dateString.isEmpty)return '';
    // Parse the string into a DateTime object
    DateTime parsedDate = DateTime.parse(dateString);

    // Define the desired format
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    // Format the parsed date
    return dateFormat.format(parsedDate).toUpperCase();  // Make it uppercase as required
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
          border: Border.all(width: 0.1, color: AppColors.strokeColor )
      ),
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
                if((subtitle ?? '').isNotEmpty)Text(
                  subtitle,
                  style: UiConstants.secondary_10_400,
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            Assets.arrowRight,
            width: 28,
            colorFilter:
            const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}