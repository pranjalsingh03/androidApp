import 'package:flutter/material.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/theme/app_colors.dart';

class AchievementCard extends StatelessWidget {
  const AchievementCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.secondaryTextColor),
      ),
      title: const Text(
        '1st Prize',
        style: darksemibold14,
      ),
      subtitle: const Text(
        'XYZ Competition',
        style: darknormal12,
      ),
    );
  }
}
