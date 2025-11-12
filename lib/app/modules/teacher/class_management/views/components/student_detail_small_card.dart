import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/theme/app_colors.dart';

class StudentDetailSmallCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String subtitle;

  const StudentDetailSmallCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 8.h, horizontal: Dimensions.defaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            // onTap: () => Get.toNamed(EditProfileScreen.routeName),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: DottedBorder(
                  borderType: BorderType.Circle,
                  strokeWidth: 2,
                  dashPattern: const [10],
                  strokeCap: StrokeCap.round,
                  color: AppColors.primaryColor.withOpacity(.1),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      onBackgroundImageError: (exception, stack) =>
                          Image.asset(AssetsConstants.userAvatar),
                      radius: 40,
                      backgroundImage: NetworkImage(
                        imageUrl,
                      ),
                    ),
                  )),
            ),
          ),
          // Bio
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.textColor,
            ),
          ),

          Text(
            subtitle,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: AppColors.secondaryTextColor),
          ),
        ],
      ),
    );
  }
}
