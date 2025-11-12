import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class TopicNameCard extends StatelessWidget {
  final List<String> topics;

  const TopicNameCard({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.defaultPadding,
        vertical: 8.h,
      ),
      decoration: ShapeDecoration(
          color: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(Dimensions.defaultRoundedCorner),
          ),
          shadows: kDefaultBoxShadows),
      child: Text(
        topics.join("\n"),
        style: kLight_14_600,
      ),
    );
  }
}
