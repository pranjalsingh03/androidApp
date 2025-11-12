import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

class TextHeaderWidget extends StatelessWidget {
  final String text;
  const TextHeaderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 1.5.h,
            color: AppColors.strokeColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(text, style: kDark_14_400),
        ),
        Expanded(
          child: Container(
            height: 1.5.h,
            color: AppColors.strokeColor,
          ),
        ),
      ],
    );
  }
}
