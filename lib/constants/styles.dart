import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';

const kFontFamily = "Lufga";

final TextStyle kAppBarText = TextStyle(
  color: AppColors.textColor,
  fontFamily: kFontFamily,
  fontSize: 16.sp,
  fontWeight: FontWeight.w600,
);

final TextStyle kLight_8_400 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 8.sp,
);
final TextStyle kLight_8_500 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w500,
  fontSize: 8.sp,
);
final TextStyle kLight_8_600 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w600,
  fontSize: 8.sp,
);
final TextStyle kLight_8_700 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 8.sp,
);

final TextStyle kLight_10_400 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 10.sp,
);
final TextStyle kLight_10_500 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w500,
  fontSize: 10.sp,
);
final TextStyle kLight_10_600 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w600,
  fontSize: 10.sp,
);
final TextStyle kLight_10_700 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 10.sp,
);

final TextStyle kLight_12_400 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 12.sp,
);
final TextStyle kLight_12_500 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w500,
  fontSize: 12.sp,
);
final TextStyle kLight_12_600 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w600,
  fontSize: 12.sp,
);
final TextStyle kLight_12_700 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 12.sp,
);

final TextStyle kLight_14_400 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
);
final TextStyle kLight_14_500 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w500,
  fontSize: 14.sp,
);
final TextStyle kLight_14_600 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w600,
  fontSize: 14.sp,
);
final TextStyle kLight_14_700 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 14.sp,
);

final TextStyle kLight_16_400 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
);
final TextStyle kLight_16_500 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
);
final TextStyle kLight_16_600 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w600,
  fontSize: 16.sp,
);
final TextStyle kLight_16_700 = TextStyle(
  color: AppColors.inverseTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 16.sp,
);

final TextStyle kLight_18_400 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 18.sp);
final TextStyle kLight_18_500 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 18.sp);
final TextStyle kLight_18_600 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp);
final TextStyle kLight_18_700 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 18.sp);

final TextStyle kDark_8_400 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w400, fontSize: 18.sp);
final TextStyle kDark_8_500 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w500, fontSize: 18.sp);
final TextStyle kDark_8_600 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w600, fontSize: 18.sp);
final TextStyle kDark_8_700 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w700, fontSize: 18.sp);

final TextStyle kDark_10_400 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w400, fontSize: 10.sp);
final TextStyle kDark_10_500 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w500, fontSize: 10.sp);
final TextStyle kDark_10_600 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w600, fontSize: 10.sp);
final TextStyle kDark_10_700 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w700, fontSize: 10.sp);

final TextStyle kDark_12_400 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w400, fontSize: 12.sp);
final TextStyle kDark_12_500 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w500, fontSize: 12.sp);
final TextStyle kDark_12_600 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w600, fontSize: 12.sp);
final TextStyle kDark_12_700 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w700, fontSize: 12.sp);

final TextStyle kDark_14_400 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w400, fontSize: 14.sp);
final TextStyle kDark_14_500 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w500, fontSize: 14.sp);
final TextStyle kDark_14_600 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w600, fontSize: 14.sp);
final TextStyle kDark_14_700 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w700, fontSize: 14.sp);

final TextStyle kDark_16_400 = TextStyle(
  color: AppColors.textColor,
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
);
final TextStyle kDark_16_500 = TextStyle(
  color: AppColors.textColor,
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
);
final TextStyle kDark_16_600 = TextStyle(
  color: AppColors.textColor,
  fontWeight: FontWeight.w600,
  fontSize: 16.sp,
);
final TextStyle kDark_16_700 = TextStyle(
  color: AppColors.textColor,
  fontWeight: FontWeight.w700,
  fontSize: 16.sp,
);

final TextStyle kDark_18_400 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w400, fontSize: 18.sp);
final TextStyle kDark_18_500 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w500, fontSize: 18.sp);
final TextStyle kDark_18_600 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w600, fontSize: 18.sp);
final TextStyle kDark_18_700 = TextStyle(
    color: AppColors.textColor, fontWeight: FontWeight.w700, fontSize: 18.sp);

final TextStyle kSecondary_8_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 18.sp);
final TextStyle kSecondary_8_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 18.sp);
final TextStyle kSecondary_8_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp);
final TextStyle kSecondary_8_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 18.sp);

final TextStyle kSecondary_10_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 10.sp);
final TextStyle kSecondary_10_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 10.sp);
final TextStyle kSecondary_10_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 10.sp);
final TextStyle kSecondary_10_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 10.sp);

final TextStyle kSecondary_12_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 12.sp);
final TextStyle kSecondary_12_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 12.sp);
final TextStyle kSecondary_12_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 12.sp);
final TextStyle kSecondary_12_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 12.sp);

final TextStyle kSecondary_14_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp);
final TextStyle kSecondary_14_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp);
final TextStyle kSecondary_14_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp);
final TextStyle kSecondary_14_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 14.sp);

final TextStyle kSecondary_16_400 = TextStyle(
  color: AppColors.secondaryTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
);
final TextStyle kSecondary_16_500 = TextStyle(
  color: AppColors.secondaryTextColor,
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
);
final TextStyle kSecondary_16_600 = TextStyle(
  color: AppColors.secondaryTextColor,
  fontWeight: FontWeight.w600,
  fontSize: 16.sp,
);
final TextStyle kSecondary_16_700 = TextStyle(
  color: AppColors.secondaryTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 16.sp,
);

final TextStyle kSecondary_18_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 18.sp);
final TextStyle kSecondary_18_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 18.sp);
final TextStyle kSecondary_18_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp);
final TextStyle kSecondary_18_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 18.sp);

// Pin Input Theme
final defaultPinTheme = PinTheme(
  width: 42.w,
  height: 42.w,
  textStyle: kDark_14_400,
  decoration: BoxDecoration(
    border: Border.all(color: AppColors.strokeColor),
    borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: AppColors.primaryColor),
  borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration!.copyWith(
    color: AppColors.whiteColor,
  ),
);
