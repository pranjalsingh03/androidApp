import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';

class CustomAppBar extends StatelessWidget {
  final String _title;

  const CustomAppBar({
    super.key,
    required String title,
  }) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Get.width,
          height: Dimensions.appBarHeight.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                _title,
                style: kAppBarText,
              ),
              const Positioned(
                left: Dimensions.defaultPadding,
                child: AppBarBackButton(),
              )
            ],
          ),
        )
      ],
    );
  }
}
