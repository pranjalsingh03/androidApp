import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/class_management/models/all_students_model.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/theme/app_colors.dart';

class AttendanceCard extends StatelessWidget {
  final StudentData student;
  final bool isSelected;

  const AttendanceCard({
    super.key,
    required this.student,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(
      builder: (controller) => GestureDetector(
          onTap: () {
            controller.toggleSelection(student.studentId);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondaryTextColor,
                          image: DecorationImage(
                            image: NetworkImage(student.imageUrl),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {},
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          student.name,
                          style: darknormal12.copyWith(
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          textScaler: TextScaler.noScaling,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Icon(
                      isSelected ? Icons.circle : Icons.circle_outlined,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.bodyTextColor,
                    )),
              ],
            ),
          )),
    );
  }
}
