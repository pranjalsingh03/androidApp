import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class ProgressTile extends StatelessWidget {
  final String title;
  final bool isCompleted;

  const ProgressTile({
    super.key,
    required this.title,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      tileColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Progress',
            style: kDark_10_400.copyWith(
              fontSize: 8,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            isCompleted ? "Completed" : "Incomplete",
            style: kDark_10_600,
          )
        ],
      ),
      subtitle: Container(
        margin: const EdgeInsets.only(top: 4),
        height: 10,
        decoration: kDefaultDecoration,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            thumbColor: AppColors.primaryColor,
            trackHeight: 10,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
            activeTrackColor: AppColors.primaryColor,
            inactiveTrackColor: const Color(0xFFD6EBF8),
          ),
          child: Slider(
            value: isCompleted ? 100 : 50,
            min: 0,
            max: 100,
            onChanged: (value) {},
          ),
        ),
      ),
      trailing: SvgPicture.asset(
        Assets.arrowRight,
        colorFilter: const ColorFilter.mode(
          AppColors.primaryColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
