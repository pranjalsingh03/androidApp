import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class LeaveMarkCard extends StatelessWidget {
  const LeaveMarkCard({super.key, required this.text, required this.press});
  final String text;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.defaultPadding / 2),
        height: 100.h,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: kDark_16_400),
                Row(
                  children: [
                    Text('View All', style: kSecondary_12_400),
                    k6XGap,
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.w,
                      color: AppColors.secondaryColor,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
