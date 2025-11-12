import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

class Loader extends StatelessWidget {
  final String text;
  const Loader({super.key, this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/loader.gif', // Path to your GIF file
          height: 70.w,
          width: 70.w,
        ),
        if (text.isNotEmpty)
          Text(
            text,
            style: kDark_14_500,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}

void showCircularDialogLoader() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.dialog(
      barrierDismissible: false,
      WillPopScope(
        onWillPop: () async => false,
        child: const Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  });
}