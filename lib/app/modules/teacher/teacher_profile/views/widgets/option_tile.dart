import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class OptionTile extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color iconColor;
  final Color bgColor;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor = AppColors.textColor,
    this.iconColor = AppColors.primaryColor,
    this.bgColor = AppColors.whiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        decoration: ShapeDecoration(
            color: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Dimensions.defaultRoundedCorner),
            ),
            shadows: kDefaultBoxShadows),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: kDark_14_500.copyWith(color: textColor),
            ),
            SvgPicture.asset(
              Assets.arrowRight,
              width: 24.w,
              height: 24.h,
              colorFilter: ColorFilter.mode(
                iconColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
