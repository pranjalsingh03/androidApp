import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

const ColorFilter kSvgDarkFilter = ColorFilter.mode(
  AppColors.textColor,
  BlendMode.srcIn,
);
const ColorFilter kSvgLightFilter = ColorFilter.mode(
  AppColors.inverseTextColor,
  BlendMode.srcIn,
);

// * Date Time Styles
EasyThemeData kEasyTheme(BuildContext context) =>
    EasyTheme.of(context).copyWithState(
      selectedDayTheme: DayThemeData(
        border: const BorderSide(color: AppColors.accentColor),
        bottomElementStyle: kLight_14_500,
        topElementStyle: kDark_14_500,
        backgroundColor: AppColors.accentColor,
        foregroundColor: AppColors.inverseTextColor,
      ),
      unselectedDayTheme: DayThemeData(
        backgroundColor: AppColors.secondaryColor,
        border: const BorderSide(color: AppColors.secondaryColor),
        bottomElementStyle: kDark_14_500,
        topElementStyle: kDark_14_500,
        foregroundColor: AppColors.textColor,
      ),
      disabledDayTheme: DayThemeData(
        border: const BorderSide(color: AppColors.whiteColor),
        bottomElementStyle: kDark_14_500,
        topElementStyle: kDark_14_500,
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.textColor,
      ),
      selectedCurrentDayTheme: DayThemeData(
        border: const BorderSide(color: AppColors.accentColor),
        bottomElementStyle: kLight_14_500,
        topElementStyle: kLight_14_500,
        backgroundColor: AppColors.accentColor,
        foregroundColor: AppColors.inverseTextColor,
      ),
      unselectedCurrentDayTheme: DayThemeData(
        border: const BorderSide(color: AppColors.secondaryColor),
        bottomElementStyle: kDark_14_500,
        topElementStyle: kDark_14_500,
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: AppColors.textColor,
      ),
    );

// Text Field Decoration
const OutlineInputBorder kDefaultOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(6)),
  borderSide: BorderSide(
    color: Color(0xFFF3F2F2),
  ),
);

const kErrorBorderSide = BorderSide(color: Colors.red, width: 1);

final InputDecorationTheme kInputDecorationTheme = InputDecorationTheme(
  fillColor: Colors.white,
  filled: true,
  contentPadding: const EdgeInsets.all(Dimensions.defaultPadding),
  border: kDefaultOutlineInputBorder.copyWith(
    borderRadius: BorderRadius.circular(12),
  ),
  enabledBorder: kDefaultOutlineInputBorder.copyWith(
    borderRadius: BorderRadius.circular(12),
  ),
  focusedBorder: kDefaultOutlineInputBorder.copyWith(
    borderSide: BorderSide(
      color: AppColors.primaryColor.withOpacity(0.5),
    ),
    borderRadius: BorderRadius.circular(12),
  ),
  errorBorder: kDefaultOutlineInputBorder.copyWith(
    borderSide: kErrorBorderSide,
    borderRadius: BorderRadius.circular(12),
  ),
  focusedErrorBorder: kDefaultOutlineInputBorder.copyWith(
    borderSide: kErrorBorderSide,
    borderRadius: BorderRadius.circular(12),
  ),
  disabledBorder: kDefaultOutlineInputBorder.copyWith(
    borderRadius: BorderRadius.circular(12),
  ),
);
const ButtonThemeData buttonThemeData = ButtonThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);

final kDefaultDecoration = ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 1, color: AppColors.strokeColor),
      borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
    ),);

final kDefaultDecorationBordered = ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 1, color: AppColors.cardBorderColor),
      borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
    ),);

final List<BoxShadow> kDefaultBoxShadows = [
  BoxShadow(
    color: Colors.black.withOpacity(.03),
    blurRadius: 15,
    offset: const Offset(0, 1),
    spreadRadius: 1,
  ),
];

const kDivider = Divider(
  color: AppColors.strokeColor,
);

final kdefaultYGap = SizedBox(height: 16.h);
final k2YGap = SizedBox(height: 2.h);
final k4YGap = SizedBox(height: 4.h);
final k6YGap = SizedBox(height: 6.h);
final k8YGap = SizedBox(height: 8.h);
final k10YGap = SizedBox(height: 10.h);
final k12YGap = SizedBox(height: 12.h);
final k14YGap = SizedBox(height: 14.h);
final k16YGap = SizedBox(height: 16.h);
final k18YGap = SizedBox(height: 18.h);
final k20YGap = SizedBox(height: 20.h);

final kdefaultXGap = SizedBox(width: 6.w);
final k2XGap = SizedBox(width: 2.w);
final k4XGap = SizedBox(width: 4.w);
final k6XGap = SizedBox(width: 6.w);
final k8XGap = SizedBox(width: 8.w);
final k10XGap = SizedBox(width: 10.w);
final k12XGap = SizedBox(width: 12.w);
final k14XGap = SizedBox(width: 14.w);
final k16XGap = SizedBox(width: 16.w);
final k18XGap = SizedBox(width: 18.w);
final k20XGap = SizedBox(width: 20.w);
