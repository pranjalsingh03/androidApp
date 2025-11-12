import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/ui_constants.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final double height;
  const FeatureCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
        ),
        padding: const EdgeInsets.all(Dimensions.defaultPadding),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                SvgPicture.asset(
                  Assets.arrowRight,
                  width: 22.w,
                  height: 22.h,
                  colorFilter: ColorFilter.mode(
                    foregroundColor,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
