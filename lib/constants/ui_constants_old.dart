import 'package:flutter/material.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

class UiConstants {
  static const double defaultPadding = 16;
  static const double defaultRoundedCorner = 5;
  static const double appBarHeight = 56;

  static const Size designSize = Size(360, 800);

  static const BorderSide kErrorBorderSide =
      BorderSide(color: Colors.red, width: 1);

  static const Duration kDefaultDuration = Duration(milliseconds: 250);

  static const EdgeInsets kTextFieldPadding = EdgeInsets.symmetric(
    horizontal: defaultPadding,
    vertical: defaultPadding,
  );

  static const ColorFilter kSvgDarkFilter = ColorFilter.mode(
    AppColors.textColor,
    BlendMode.srcIn,
  );
  static const ColorFilter kSvgLightFilter = ColorFilter.mode(
    AppColors.inverseTextColor,
    BlendMode.srcIn,
  );

  static final defaultDecoration = ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRoundedCorner),
      ),
      );

  static final defaultProfileDecoration = ShapeDecoration(
      color: Colors.orange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultRoundedCorner),
      ),
      );

  static final defaultDecorationBordered = ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 1, color: AppColors.cardBorderColor),
        borderRadius: BorderRadius.circular(defaultRoundedCorner),
      ),
      );

  static List<BoxShadow> defaultBoxShadows = [
    // BoxShadow(
    //   color: Colors.black.withOpacity(.03),
    //   blurRadius: 15,
    //   offset: const Offset(0, 1),
    //   spreadRadius: 1,
    // ),
  ];

  // * Text Styles
  static const appBarTitle = TextStyle(
    color: AppColors.textColor,
    fontFamily: kFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // Light Color Styles
  static const TextStyle light_8_400 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 8,
  );
  static const TextStyle light_8_500 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 8,
  );
  static const TextStyle light_8_600 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 8,
  );
  static const TextStyle light_8_700 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 8,
  );

  static const TextStyle light_10_400 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static const TextStyle light_10_500 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  static const TextStyle light_10_600 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  static const TextStyle light_10_700 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 10,
  );

  static const TextStyle light_12_400 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static const TextStyle light_12_500 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static const TextStyle light_12_600 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static const TextStyle light_12_700 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  static const TextStyle light_14_400 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static const TextStyle light_14_500 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle light_14_600 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static const TextStyle light_14_700 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const TextStyle light_16_400 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static const TextStyle light_16_500 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle light_16_600 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle light_16_700 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const TextStyle light_18_400 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static const TextStyle light_18_500 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static const TextStyle light_18_600 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static const TextStyle light_18_700 = TextStyle(
    color: AppColors.inverseTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  // Dark Color Styles
  static const TextStyle dark_8_400 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 8,
  );
  static const TextStyle dark_8_500 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 8,
  );
  static const TextStyle dark_8_600 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w600,
    fontSize: 8,
  );
  static const TextStyle dark_8_700 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 8,
  );

  static const TextStyle dark_10_400 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static const TextStyle dark_10_500 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  static const TextStyle dark_10_600 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  static const TextStyle dark_10_700 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 10,
  );

  static const TextStyle dark_12_400 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static const TextStyle dark_12_500 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static const TextStyle dark_12_600 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static const TextStyle dark_12_700 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  static const TextStyle dark_14_400 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static const TextStyle darkk_14_500 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static const TextStyle dark_14_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const TextStyle dark_14_log500 = TextStyle(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle dark_14_600 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static const TextStyle dark_14_700 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const TextStyle dark_16_400 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static const TextStyle dark_16_500 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle dark_16_600 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle dark_16_700 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const TextStyle dark_18_400 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static const TextStyle dark_18_500 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static const TextStyle dark_18_600 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static const TextStyle dark_18_700 = TextStyle(
    color: AppColors.textColor,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

// Secondary Color Styles
  static const TextStyle secondary_8_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 8,
  );
  static const TextStyle secondary_8_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 8,
  );
  static const TextStyle secondary_8_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 8,
  );
  static const TextStyle secondary_8_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 8,
  );

  static const TextStyle secondary_10_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  static const TextStyle secondary_10_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  static const TextStyle secondary_10_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  static const TextStyle secondary_10_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 10,
  );

  static const TextStyle secondary_12_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static const TextStyle secondary_12_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static const TextStyle secondary_12_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static const TextStyle secondary_12_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  static const TextStyle secondary_14_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static const TextStyle secondary_14_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle secondary_14_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static const TextStyle secondary_14_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const TextStyle secondary_16_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static const TextStyle secondary_16_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle secondary_16_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle secondary_16_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const TextStyle secondary_18_400 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static const TextStyle secondary_18_500 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static const TextStyle secondary_18_600 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static const TextStyle secondary_18_700 = TextStyle(
    color: AppColors.secondaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );
}
