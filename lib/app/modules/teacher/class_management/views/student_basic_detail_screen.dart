import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/student_detail_small_card.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/table_row_text.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/controllers/class_management_controller.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';

class StudentBasicDetailScreen extends StatelessWidget {
  const StudentBasicDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Details'),
        leading: const AppBarBackButton(),
      ),
      body: GetBuilder<ManagementController>(
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
            child: Column(
              children: [
                k16YGap,
                StudentDetailSmallCard(
                  imageUrl: controller.studentDetail?.imageUrl ?? "",
                  name: controller.studentDetail?.name ?? "",
                  subtitle:
                      "${controller.studentDetail?.className} ${controller.studentDetail?.section} | Roll No: ${controller.studentDetail?.rollNum}",
                ),
                k16YGap,
                Container(
                  padding: const EdgeInsets.all(Dimensions.defaultPadding),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: kDark_16_600,
                      ),
                      k8YGap,
                      TableRowText(
                        cat: 'DOB',
                        value: controller.studentDetail?.dob ?? "N/A",
                      ),
                      kDivider,
                      TableRowText(
                        cat: 'Email',
                        value: controller.studentDetail?.email ?? "N/A",
                      ),
                      kDivider,
                      TableRowText(
                        cat: 'Phone No',
                        value: controller.studentDetail?.phoneNo ?? "N/A",
                      ),
                      k20YGap,
                      k10YGap,
                      // parent information card
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Parent Information',
                              style: kDark_16_600,
                            ),
                            k8YGap,
                            TableRowText(
                              cat: 'Father\'s Name',
                              value: controller.studentDetail?.parentDetails
                                      ?.fatherDetails?.name ?? "N/A",
                            ),
                            kDivider,
                            TableRowText(
                              cat: 'Mother\'s Name',
                              value: controller.studentDetail?.parentDetails
                                      ?.motherDetails?.name ?? "N/A",
                            ),
                            kDivider,
                            TableRowText(
                              cat: 'Father\'s Phone',
                              value: controller.studentDetail?.parentDetails
                                      ?.fatherDetails?.phoneNo ?? "N/A",
                            ),
                            kDivider,
                            TableRowText(
                              cat: 'Mother\'s Phone',
                              value: controller.studentDetail?.parentDetails
                                      ?.motherDetails?.phoneNo ?? "N/A",
                            ),
                            kDivider,
                            TableRowText(
                              cat: 'Father\'s Occupation',
                              value: controller.studentDetail?.parentDetails
                                      ?.fatherDetails?.occupation ?? "N/A",
                            ),
                            kDivider,
                            TableRowText(
                              cat: 'Mother\'s Occupation',
                              value: controller.studentDetail?.parentDetails
                                      ?.motherDetails?.occupation ?? "N/A",
                            ),
                          ],
                        ),
                      ),
                      k20YGap,
                      k10YGap,
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Extra Curriculum',
                              style: kDark_16_600,
                            ),
                            k8YGap,
                            ..._buildExtraCurricularList(controller),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExtraCurricularList(ManagementController controller) {
    final Map<String, List<String>> activityMap = {};

    for (var activity in controller.studentDetail?.extraCurricular ?? []) {
      if (activityMap.containsKey(activity.activityName)) {
        activityMap[activity.activityName]!.add(activity.activityDetails);
      } else {
        activityMap[activity.activityName] = [activity.activityDetails];
      }
    }

    return activityMap.entries.map((entry) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableRowText(
            cat: entry.key,
            value: entry.value.join(', '),
          ),
          kDivider,
        ],
      );
    }).toList();
  }
}