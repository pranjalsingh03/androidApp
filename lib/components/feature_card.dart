import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';

class FeatureCard extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;
  final double height;

  const FeatureCard({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    required this.height,
    this.bgColor = Colors.white,
    this.textColor = AppColors.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius:
                BorderRadius.circular(Dimensions.defaultRoundedCorner),
            border: (text.contains('AI')) ? null : Border.all(width: 1, color: AppColors.strokeColor )
          // shadows: UiConstants.defaultBoxShadows,
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SvgPicture.asset(iconPath),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: kDark_12_500.copyWith(color: textColor),
                ),
                SvgPicture.asset(
                  Assets.arrowRight,
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCardText extends StatelessWidget {
  final String? iconPath;
  final String text;
  final VoidCallback onTap;
  final Color bgColor;
  final Color textColor;
  final double height;

  const FeatureCardText({
    super.key,
    this.iconPath,
    required this.text,
    required this.onTap,
    required this.height,
    this.bgColor = Colors.white,
    this.textColor = AppColors.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius:
          BorderRadius.circular(Dimensions.defaultRoundedCorner),
          border: (text.contains('Notification')) ? null : Border.all(width: 1, color: AppColors.strokeColor )
          // shadows: UiConstants.defaultBoxShadows,
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconPath == null
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        iconPath!,
                        width: 12.w,
                        colorFilter: ColorFilter.mode(
                          textColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  text,
                  style: kDark_12_500.copyWith(color: textColor),
                ),
                SvgPicture.asset(
                  Assets.arrowRight,
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
