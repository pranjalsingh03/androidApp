import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/model/bottom_nav_item_model.dart';
import 'package:sheshya/app/data/model/teacher/response/teacher_profile_model.dart';
import 'package:sheshya/app/modules/teacher/attendence/attendence_report_screen.dart';
import 'package:sheshya/app/modules/teacher/attendence/attendence_screen.dart';
import 'package:sheshya/app/modules/teacher/attendence/components/attendance_nav_items.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/app/modules/teacher/attendence/leave_application_screen.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/teacher_profile_view.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class AttendanceRootScreen extends StatefulWidget {
  final TeacherProfileModel teacher;
  const AttendanceRootScreen({super.key, required this.teacher});

  @override
  State<AttendanceRootScreen> createState() => _AttendanceRootScreenState();
}

class _AttendanceRootScreenState extends State<AttendanceRootScreen> {
  final AttendanceController controller = Get.find<AttendanceController>();

  @override
  void initState() {
    super.initState();
    controller.changeIndex(1);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(
      builder: (controller) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.whiteColor,
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                // 0
                const SizedBox.shrink(),
                // 1
                const AttendanceScreen(),
                // 2
                LeaveApplicationScreen(),
                // 3
                // Scaffold(
                //   appBar: AppBar(
                //     title: const Text("Report"),
                //     automaticallyImplyLeading: false,
                //     leading: null,
                //     actions: [
                //       !controller.isLoadingClass.value
                //           ? CircleAvatar(
                //               backgroundColor: AppColors.primaryColor,
                //               child: Text(
                //                 '${controller.selectedClass.value}${controller.selectedSection.value}',
                //                 style: kLight_10_500,
                //               ),
                //             )
                //           : const SizedBox.shrink(),
                //       k16XGap,
                //     ],
                //   ),
                // ),
                // 4
                AttendanceReportScreen(),
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
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var item in attendanceBottomNavItems)
                  bottomNavItem(controller, item,
                      controller.selectedIndex.value == item.index),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector bottomNavItem(AttendanceController controller,
      BottomNavItemModel item, bool isSelected) {
    return GestureDetector(
      onTap: () => {
        if (item.index == 0)
          {
            Get.back(),
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
