// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/bottom_nav_item_model.dart';
import 'package:sheshya/app/modules/teacher/exams/examination_screen.dart';
import 'package:sheshya/app/modules/teacher/home/controllers/teacher_home_controller.dart';
import 'package:sheshya/app/modules/teacher/home/views/components/bottom_nav_bar_items.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/classroom_select_screen.dart';
import 'package:sheshya/app/modules/teacher/teacher_dashboard/views/teacher_dashboard.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/teacher_profile_view.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/app/modules/parent/chatbox/chatbox_screen.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/app/modules/teacher/chatbox/chatbox_screen.dart';

class TeacherHomeView extends StatefulWidget {
  const TeacherHomeView({super.key});

  @override
  State<TeacherHomeView> createState() => _TeacherHomeViewState();
}

class _TeacherHomeViewState extends State<TeacherHomeView> {
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    final controller = Get.find<TeacherHomeController>();
    controller.changeIndex(0);
  }

  Future<bool> onWillPop() {
    final controller = Get.find<TeacherHomeController>();
    if (controller.selectedIndex != 0) {
      controller.changeIndex(0);
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      showCustomSnackBar("Press again to exit",
          duration: const Duration(seconds: 2), type: SnackBarType.info);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: GetBuilder<TeacherHomeController>(
        builder: (controller) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            systemNavigationBarColor: AppColors.whiteColor,
            statusBarColor: AppColors.backgroundColor,
          ),
          child: Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: controller.selectedIndex,
                children: [
                  // Dashboard
                  const TeacherDashboard(),
                  // Exams
                  const ExaminationScreen(),
                  // Classroom
                  Container(),
                  // Chatbox
                  TeacherChatboxScreen(),
                  // Container(),
                  // Profile
                  const TeacherProfileView(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: 58.h,
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(width: 2, color: AppColors.dividercolor),
                  top: BorderSide(width: 0.5, color: AppColors.dividercolor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var item in teacherHomeBottomNavItems)
                    bottomNavItem(controller, item,
                        controller.selectedIndex == item.index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector bottomNavItem(TeacherHomeController controller,
      BottomNavItemModel item, bool isSelected) {
    return GestureDetector(
      onTap: () => {
        if (item.index == 2)
          {
            Get.to(
              () => const ClassroomSelectScreen(),
            ),
          }
        else
          {
            controller.changeIndex(item.index),
          }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              item.assetPath,
              colorFilter: ColorFilter.mode(
                  isSelected ? item.selectedColor : item.color,
                  BlendMode.srcIn),
            ),
            Text(
              item.name,
              style: kDark_10_400.copyWith(
                color: isSelected ? item.selectedColor : item.color,
                fontWeight: item.index == 0
                    ? FontWeight.w500
                    : isSelected
                        ? FontWeight.w500
                        : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
