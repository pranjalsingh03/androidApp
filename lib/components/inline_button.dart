import 'package:flutter/material.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class InlineIconButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final TextStyle textStyle;

  const InlineIconButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
    this.iconSize = 18,
    this.iconColor = AppColors.secondaryTextColor,
    this.textStyle = const TextStyle(
      color: AppColors.secondaryTextColor,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
          k6XGap,
          Text(text, style: textStyle),
        ],
      ),
    );
  }
}
