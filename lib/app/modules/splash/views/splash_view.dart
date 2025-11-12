import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sheshya/app/modules/splash/controllers/splash_controller.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/helper/system_ui.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<SplashController>().checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUi.defaultStyle,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Lottie.asset(
              Assets.splashAnimation,
              width: 300.w,
              height: 300.w,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
