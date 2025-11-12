import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/components/classroom_actions.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

class ActionCard extends StatelessWidget {
  final MapEntry<int, ClassroomAction> entry;
  const ActionCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 16.w,
        left: entry.key == 0 ? 16.w : 0,
      ),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      height: 162.h,
      width: 150.w,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.textColor),
          borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Image
          SvgPicture.asset(entry.value.assetPath),
          // Bottom
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.value.title,
                  style: kDark_12_500,
                ),
                SvgPicture.asset(
                  Assets.arrowRight,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
