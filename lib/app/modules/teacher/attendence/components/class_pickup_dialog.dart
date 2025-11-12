import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/theme/app_colors.dart';

class ClassPickupDialog extends StatelessWidget {
  const ClassPickupDialog(
      {super.key,
      required this.controller,
      required this.classes,
      required this.sections});
  final AttendanceController controller;
  final List<String> classes;
  final List<String> sections;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 170,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    "Select Class",
                    style: darksemibold16.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    textScaler: TextScaler.noScaling,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 40,
                      viewportFraction: 0.3,
                      initialPage: classes.indexWhere((element) =>
                          element == controller.selectedClass.value),
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        controller.selectedClass.value = classes[index];
                      },
                    ),
                    items: classes.map((clas) {
                      return Center(
                        child: Obx(() {
                          return Text(
                            clas,
                            style: TextStyle(
                              fontSize: 20,
                              color: controller.selectedClass.value == clas
                                  ? AppColors.bodyTextColor
                                  : AppColors.textaccentColor,
                              fontWeight: controller.selectedClass.value == clas
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                            textScaler: TextScaler.noScaling,
                          );
                        }),
                      );
                    }).toList(),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 30,
                      viewportFraction: 0.2,
                      initialPage: sections.indexWhere((element) =>
                          element == controller.selectedSection.value),
                      // enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        controller.selectedSection.value = sections[index];
                      },
                    ),
                    items: sections.map((sec) {
                      // int sectInd = sections.indexOf(sec) + 1;
                      return Center(
                        child: Obx(() {
                          return Text(
                            sec,
                            style: TextStyle(
                              fontSize: 12,
                              color: controller.selectedSection.value == sec
                                  ? AppColors.bodyTextColor
                                  : AppColors.textaccentColor,
                              fontWeight:
                                  controller.selectedSection.value == sec
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                            ),
                            textScaler: TextScaler.noScaling,
                          );
                        }),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: AppColors.primaryColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Text(
                      'Select Class',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
