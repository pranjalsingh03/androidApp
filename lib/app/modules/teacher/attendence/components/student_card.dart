import 'package:flutter/material.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/theme/app_colors.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                const CircleAvatar(
                  backgroundColor: AppColors.secondaryTextColor,
                  radius: 19,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: darknormal14.copyWith(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textScaler: TextScaler.noScaling,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
