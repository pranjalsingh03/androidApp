import 'package:flutter/material.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/modules/teacher/class_management/models/all_students_model.dart';

class LeaveTeacherCard extends StatelessWidget {
  final StudentData student;

  const LeaveTeacherCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      tileColor: Colors.white,
      leading: const Padding(
        padding: EdgeInsets.only(top: 8),
        child: CircleAvatar(
          backgroundColor: AppColors.secondaryTextColor,
          radius: 25,
        ),
      ),
      isThreeLine: true,
      title: Text(
        student.name,
        style: darksemibold16,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Roll Number : ${student.rollNum}',
            style: darknormal10,
          ),
          // Text(
          //   student.leaveDetail.reason ?? 'No reason provided',
          //   style: darknormal12,
          // ),
        ],
      ),
    );
  }
}