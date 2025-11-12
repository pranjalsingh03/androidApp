import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? color;
  final IconData? icon;
  final double radius;
  final Color? foregroundColor;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.icon,
    this.color = AppColors.primaryColor,
    this.radius = Dimensions.defaultRoundedCorner,
    this.foregroundColor = AppColors.inverseTextColor, CircularProgressIndicator? child,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? AppColors.disabledColor
          : transparent
              ? Colors.transparent
              : color ?? AppColors.primaryColor,
      minimumSize: Size(width != null ? width! : double.infinity,
          height != null ? height! : Dimensions.defaultButtonHeight.h),
      padding: EdgeInsets.zero,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    );

    return Padding(
      padding: margin == null ? const EdgeInsets.all(0) : margin!,
      child: TextButton(
        onPressed: onPressed as void Function()?,
        style: flatButtonStyle,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null
              ? Icon(
                  icon,
                  color: transparent
                      ? Theme.of(context).primaryColor
                      : AppColors.transparentColor,
                )
              : const SizedBox(),
          SizedBox(width: icon != null ? Dimensions.defaultPadding : 0),
          Text(buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: foregroundColor,
                fontSize: fontSize ?? 14.sp,
                fontWeight: FontWeight.w400,
              )),
        ]),
      ),
    );
  }
}
