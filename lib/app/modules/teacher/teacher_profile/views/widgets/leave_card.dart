import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/models/leaves_res_model.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/extensions_helper.dart';
import 'package:sheshya/theme/app_colors.dart';

class LeaveCard extends StatefulWidget {
  final LeaveModel leave;

  const LeaveCard({
    super.key,
    required this.leave,
  });

  @override
  State<LeaveCard> createState() => _LeaveCardState();
}

class _LeaveCardState extends State<LeaveCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        isExpanded = !isExpanded;
      }),
      child: Container(
        decoration: kDefaultDecorationBordered,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${DateFormat('dd MMM, yyyy').format(widget.leave.date)}',
                        style: kSecondary_10_500,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey,
                  ),
                ],
              ),
              if (isExpanded) ...[
                kdefaultYGap,
                Text(
                  widget.leave.reason,
                  style: kSecondary_10_500.copyWith(
                    color: AppColors.tertiaryTextColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}