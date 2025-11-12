import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/theme/app_colors.dart';

class DateCard extends StatelessWidget {
  const DateCard({
    super.key,
    required this.date,
    required this.controller,
    required this.isBeforeToday,
    required this.weekdays,
    required this.isSelected,
  });

  final DateTime date;
  final AttendanceController controller;
  final bool isBeforeToday;
  final List<String> weekdays;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: date.day == controller.selectedDate.value.day &&
                    date.month == controller.selectedDate.value.month &&
                    date.year == controller.selectedDate.value.year
                ? AppColors.accentColor
                : isBeforeToday
                    ? AppColors.bodyTextColor
                    : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () => Text(
                  weekdays[date.weekday - 1],
                  style: TextStyle(
                    fontSize: 14,
                    color: date.day == controller.selectedDate.value.day &&
                            date.month == controller.selectedDate.value.month &&
                            date.year == controller.selectedDate.value.year
                        ? Colors.white
                        : isBeforeToday
                            ? Colors.white
                            : Colors.black,
                    fontWeight: date.day == controller.selectedDate.value.day &&
                            date.month == controller.selectedDate.value.month &&
                            date.year == controller.selectedDate.value.year
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  textScaler: TextScaler.noScaling,
                ),
              ),
              Obx(
                () => Text(
                  date.day.toString(),
                  style: TextStyle(
                      color: date.day == controller.selectedDate.value.day &&
                              date.month ==
                                  controller.selectedDate.value.month &&
                              date.year == controller.selectedDate.value.year
                          ? Colors.white
                          : isBeforeToday
                              ? Colors.white
                              : Colors.black,
                      fontWeight: date.day ==
                                  controller.selectedDate.value.day &&
                              date.month ==
                                  controller.selectedDate.value.month &&
                              date.year == controller.selectedDate.value.year
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14),
                  textScaler: TextScaler.noScaling,
                ),
              ),
            ],
          ),
        ));
  }
}
