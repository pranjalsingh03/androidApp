import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/theme/app_colors.dart';

class MontYearPickupDialog extends StatelessWidget {
  const MontYearPickupDialog({
    super.key,
    required this.controller,
    required this.years,
    required this.months,
  });

  final AttendanceController controller;
  final List<int> years;
  final List<String> months;

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
                    "Calendar",
                    style: darksemibold16.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    textScaler: TextScaler.noScaling,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 40,
                      viewportFraction: 0.3,
                      initialPage: controller.selectedYear.value - 2000,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        controller.selectedYear.value = 2000 + index;
                      },
                    ),
                    items: years.map((year) {
                      return Center(
                        child: Obx(() {
                          return Text(
                            '$year',
                            style: TextStyle(
                              fontSize: 20,
                              color: controller.selectedYear.value == year
                                  ? AppColors.bodyTextColor
                                  : AppColors.textaccentColor,
                              fontWeight: controller.selectedYear.value == year
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
                      initialPage: controller.selectedMonth.value - 1,
                      // enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        controller.selectedMonth.value = index + 1;
                      },
                    ),
                    items: months.map((month) {
                      int monthIndex = months.indexOf(month) + 1;
                      return Center(
                        child: Obx(() {
                          return Text(
                            month,
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  controller.selectedMonth.value == monthIndex
                                      ? AppColors.bodyTextColor
                                      : AppColors.textaccentColor,
                              fontWeight:
                                  controller.selectedMonth.value == monthIndex
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
                      'Select month',
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
