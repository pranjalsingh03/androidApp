import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../../../../constant.dart';
import 'academic_subject_screen.dart';


class AcademicPerformanceScreen extends GetView<AcademicExamController>  {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: Text(controller.selectedSubjectName.value),
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
    if(controller.isGetAcademicPerformanceLoading.value.isLoading){
      return Column(
        children: [
          CircularProgressIndicator(),
        ],
      );
    }
    else if( controller.isGetAcademicPerformanceLoading.value.isError){
      return GestureDetector(
          onTap: (){
            controller.loadAcademicPerformance();
          },
          child: Text('retry')
      );
    }
    else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: AppColors.strokeColor )
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AssetsConstants.examIcon,
                        fit: BoxFit.cover,
                        width: 45,
                        height: 45,
                      ),
                      SizedBox(height: 14,),
                      Text(
                        (controller?.getAcademicPerformanceModel?.data?.lowestMarks ?? '--').toString(),
                        style: UiConstants.dark_12_600,
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Lowest",
                          style: UiConstants.secondary_12_400
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 26),
              Expanded(
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: AppColors.strokeColor )
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AssetsConstants.examIcon,
                        fit: BoxFit.cover,
                        width: 45,
                        height: 45,
                      ),
                      SizedBox(height: 14,),
                      Text(
                        (controller?.getAcademicPerformanceModel?.data?.highestMarks ?? '--').toString(),
                        style: UiConstants.dark_12_600,
                      ),
                      SizedBox(height: 8,),
                      Text(
                          "Highest",
                          style: UiConstants.secondary_12_400
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 26,),
          Container(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: AppColors.strokeColor )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset(
                      AssetsConstants.energy,
                      // fit: BoxFit.cover,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      (controller?.getAcademicPerformanceModel?.data?.totalMarks ?? '--').toString(),
                      style: UiConstants.dark_18_600,
                    ),
                    SizedBox(height: 5,),
                    Text(
                        "Total Marks",
                        style: UiConstants.secondary_12_400
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      AssetsConstants.flame,
                      // fit: BoxFit.cover,
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      (controller?.getAcademicPerformanceModel?.data?.marksObtained ?? '--').toString(),
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                        "Marks Obtained",
                        style: UiConstants.secondary_12_400
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 6,),
          Container(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            margin: const EdgeInsets.only(bottom: 16),
            height: 280,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: AppColors.strokeColor )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsConstants.academicIcon,
                      // fit: BoxFit.cover,
                      width: 140,
                      height: 120,
                    ),
                    Text(
                      "${(controller?.getAcademicPerformanceModel?.data?.studentPosition ?? '--').toString()}%",
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                      ),
                    ),
                    Text(
                        "of the Ahead of Class",
                        style: UiConstants.secondary_16_500
                    ),
                  ],
                ),
              ],
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
            colorFilter:
            const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}