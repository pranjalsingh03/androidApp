import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class AvatarComponent extends StatelessWidget {
  final String image;
  const AvatarComponent({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: CircleAvatar(
            onBackgroundImageError: (exception, stack) =>
                Image.asset(AssetsConstants.userAvatar),
            radius: 40.r,
            backgroundImage: NetworkImage(
              image,
            ),
          ),
        ),
        Positioned(
          bottom: 12.w,
          right: 12.w,
          child: Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
