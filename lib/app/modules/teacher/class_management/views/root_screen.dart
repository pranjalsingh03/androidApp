import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/bottom_nav_item_model.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/achievements_screen.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/management_nav_items.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/controllers/class_management_controller.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

class ClassManagementRootScreen extends StatefulWidget {
  final String className;
  final String sectionName;
  const ClassManagementRootScreen(
      {super.key, required this.className, required this.sectionName});

  @override
  State<ClassManagementRootScreen> createState() =>
      _ClassManagementRootScreenState();
}

class _ClassManagementRootScreenState extends State<ClassManagementRootScreen> {
  final ManagementController controller = Get.put(ManagementController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.whiteColor,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.selectedIndex,
            children: [
              // Add your screens here
              Container(),
              Container(),
              // ClassManageMentScreen(),
              Container(),
              // const AchievementScreen(),
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
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var item in teacherClassManagementNavItems)
                bottomNavItem(
                    controller, item, controller.selectedIndex == item.index),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector bottomNavItem(ManagementController controller,
      BottomNavItemModel item, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.changeIndex(item.index),
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
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
