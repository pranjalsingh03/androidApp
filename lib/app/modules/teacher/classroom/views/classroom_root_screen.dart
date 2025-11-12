import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/bottom_nav_item_model.dart';
import 'package:sheshya/app/modules/teacher/classroom/controllers/teacher_classroom_controller.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/classroom_home.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/components/classroom_nav_items.dart';
import 'package:sheshya/app/modules/teacher/classroom/views/recent_tests.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/theme/app_colors.dart';

class ClassroomRootScreen extends StatefulWidget {
  const ClassroomRootScreen({super.key});

  @override
  State<ClassroomRootScreen> createState() => _ClassroomRootScreenState();
}

class _ClassroomRootScreenState extends State<ClassroomRootScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherClassroomController>(
        builder: (controller) => Scaffold(
              body: SizedBox(
                height: Get.height,
                width: Get.width,
                child: IndexedStack(
                  index: controller.selectedIndex,
                  children: [
                    Container(),
                    const ClassroomHomeScreen(),
                    const RecentTests(),
                    Container(),
                    Container(),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        bottomNavItem(
                          classroomBottomNavItems[0],
                          controller.selectedIndex == 0,
                          controller,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          width: 1,
                          color: AppColors.dividercolor,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          for (var i = 1;
                              i < classroomBottomNavItems.length;
                              i++)
                            bottomNavItem(
                              classroomBottomNavItems[i],
                              controller.selectedIndex ==
                                  classroomBottomNavItems[i].index,
                              controller,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget bottomNavItem(
    BottomNavItemModel item,
    bool isSelected,
    TeacherClassroomController controller,
  ) {
    return GestureDetector(
      onTap: () => controller.updateSelectedIndex(item.index),
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
