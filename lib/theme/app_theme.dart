import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: kFontFamily,
    colorSchemeSeed: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      titleTextStyle: UiConstants.appBarTitle,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionHandleColor: AppColors.primaryColor,
      selectionColor: AppColors.primaryColor.withOpacity(.25),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.textColor,
      indicatorColor: AppColors.primaryColor,
      labelStyle: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppColors.secondaryTextColor,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      unselectedLabelColor: AppColors.unSelectedItemColor,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerHeight: 2.h,
      dividerColor: AppColors.strokeColor,
    ),
    inputDecorationTheme:
        kInputDecorationTheme.copyWith(fillColor: Colors.white),
    buttonTheme: buttonThemeData,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 42.h),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UiConstants.defaultRoundedCorner),
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.bodyTextColor, fontSize: 12),
      bodySmall: TextStyle(color: AppColors.bodyTextColor, fontSize: 10),
      bodyLarge: TextStyle(color: AppColors.bodyTextColor, fontSize: 16),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      unselectedItemColor: AppColors.unSelectedItemColor,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        color: AppColors.unSelectedItemColor,
        fontWeight: FontWeight.w500,
      ),
      selectedItemColor: AppColors.primaryColor,
      selectedLabelStyle: TextStyle(
        color: AppColors.selectedItemColor,
        fontSize: 12,
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all<Color>(AppColors.primaryColor),
      trackColor: WidgetStateProperty.all<Color>(AppColors.primaryColor),
      trackBorderColor: WidgetStateProperty.all<Color>(AppColors.primaryColor),
    ),
  );
}
