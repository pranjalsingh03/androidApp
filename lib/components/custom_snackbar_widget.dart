import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sheshya/constants/app_constants.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';

void showCustomSnackBar(
  String? message, {
  SnackBarType type = SnackBarType.error,
  Duration duration = AppConstants.defaultSnackBarDuration,
}) {
  final colors = _getSnackBarColors(type);

  Get.showSnackbar(GetSnackBar(
    backgroundColor: colors.backgroundColor,
    icon: Icon(
      type == SnackBarType.success
          ? Icons.verified_user
          : type == SnackBarType.info
              ? Icons.info
              : type == SnackBarType.warning
                  ? Icons.warning
                  : type == SnackBarType.error
                      ? Icons.error
                      : Icons.keyboard_arrow_right,
      color: colors.textColor,
    ),
    messageText: Text(
      message ?? '',
      style: kDark_12_400.copyWith(
        color: colors.textColor,
      ),
    ),
    duration: duration,
    snackStyle: SnackStyle.FLOATING,
    margin: const EdgeInsets.all(Dimensions.defaultPadding),
    borderRadius: 5,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    borderColor: colors.borderColor,
    borderWidth: 1,
  ));
}

enum SnackBarType { normal, success, info, warning, error }

class SnackBarColorScheme {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const SnackBarColorScheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  factory SnackBarColorScheme.normal() => SnackBarColorScheme(
        backgroundColor: const HSLColor.fromAHSL(1, 0, 0, 1).toColor(),
        borderColor: const HSLColor.fromAHSL(1, 0, 0, 0.93).toColor(),
        textColor: const HSLColor.fromAHSL(1, 0, 0, 0.09).toColor(),
      );

  factory SnackBarColorScheme.success() => SnackBarColorScheme(
        backgroundColor: const HSLColor.fromAHSL(1, 143, 0.85, 0.96).toColor(),
        borderColor: const HSLColor.fromAHSL(1, 145, 0.92, 0.91).toColor(),
        textColor: const HSLColor.fromAHSL(1, 140, 1, 0.27).toColor(),
      );

  factory SnackBarColorScheme.info() => SnackBarColorScheme(
        backgroundColor: const HSLColor.fromAHSL(1, 208, 1, 0.97).toColor(),
        borderColor: const HSLColor.fromAHSL(1, 221, 0.91, 0.91).toColor(),
        textColor: const HSLColor.fromAHSL(1, 210, 0.92, 0.45).toColor(),
      );

  factory SnackBarColorScheme.warning() => SnackBarColorScheme(
        backgroundColor: const HSLColor.fromAHSL(1, 49, 1, 0.97).toColor(),
        borderColor: const HSLColor.fromAHSL(1, 49, 0.91, 0.91).toColor(),
        textColor: const HSLColor.fromAHSL(1, 31, 0.92, 0.45).toColor(),
      );

  factory SnackBarColorScheme.error() => SnackBarColorScheme(
        backgroundColor: const HSLColor.fromAHSL(1, 359, 1, 0.97).toColor(),
        borderColor: const HSLColor.fromAHSL(1, 359, 1, 0.94).toColor(),
        textColor: const HSLColor.fromAHSL(1, 360, 1, 0.45).toColor(),
      );
}

SnackBarColorScheme _getSnackBarColors(SnackBarType type) {
  switch (type) {
    case SnackBarType.success:
      return SnackBarColorScheme.success();
    case SnackBarType.info:
      return SnackBarColorScheme.info();
    case SnackBarType.warning:
      return SnackBarColorScheme.warning();
    case SnackBarType.error:
      return SnackBarColorScheme.error();
    case SnackBarType.normal:
    default:
      return SnackBarColorScheme.normal();
  }
}
