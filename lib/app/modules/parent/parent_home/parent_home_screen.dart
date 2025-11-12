// ignore_for_file: constant_identifier_names
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/modules/parent/activity/activity_screen.dart';
import 'package:sheshya/app/modules/parent/chatbox/chatbox_screen.dart';
import 'package:sheshya/app/modules/parent/leave_attendance/leave_attendance_screen.dart';
import 'package:sheshya/app/modules/parent/parent_fees_tuition/parent_tution_fee_screen.dart';
import 'package:sheshya/app/modules/parent/parent_home/parent_home_controller.dart';
import 'package:sheshya/app/modules/parent/parent_payment_method/payment_method_screen.dart';
import 'package:sheshya/app/modules/student/student_new/dashboard_new.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/app/modules/parent/performance/performance_screen.dart';
import 'package:sheshya/app/modules/parent/profile/parent_profile_screen.dart';
import 'package:sheshya/app/modules/student/dashboard/student_dashboard_screen.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/app/data/model/ui_models/fee_model.dart';
import 'package:sheshya/app/modules/parent/parent_notification/parent_notification_screen.dart';
import 'package:sheshya/constants/assets.dart';

import '../../../../constants/styles.dart';
import '../../student/edit_profile/edit_profile_screen.dart';
import '../academic/academic_exams_screen.dart';
import '../leave_attendance/leave_attendance_controller.dart';
import '../parent_notification/parenting_notification_controller.dart';

const firstName = "Arav";

enum DayStatus {
  PAST,
  TODAY,
  UPCOMING,
}

class DayModel {
  String dayCode;
  DayStatus status;
  DayModel({
    required this.dayCode,
    required this.status,
  });
}

List<DayModel> days = [
  DayModel(dayCode: "M", status: DayStatus.UPCOMING),
  DayModel(dayCode: "T", status: DayStatus.UPCOMING),
  DayModel(dayCode: "W", status: DayStatus.UPCOMING),
  DayModel(dayCode: "T", status: DayStatus.UPCOMING),
  DayModel(dayCode: "F", status: DayStatus.UPCOMING),
  DayModel(dayCode: "S", status: DayStatus.UPCOMING),
];

class ParentHomeScreen extends GetView<ParentHomeController> {
  static const routeName = "/parent-home";

  ParentHomeScreen({super.key});

  @override
  final ParentHomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {

    controller.loadStudentProfile();

    return  Obx(
      ()=> Scaffold(
        appBar: AppBar(
          leadingWidth: 0,
          leading: const Padding(padding: EdgeInsets.only(left: 16)),
          centerTitle: false,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                controller.studentProfileResModel?.data?.basic?.name ?? '--',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              const SizedBox(width: 14),
              SvgPicture.asset(
                AssetsConstants.arrowDown,
                height: 18,
                width: 18,
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: (){
                Get.to(() => ParentNotificationScreen());
              },
              icon: SvgPicture.asset(
                AssetsConstants.notification,
                height: 24,
                width: 24,
              ),
            ),
            const SizedBox(width: 14),
          ],
        ),
        body: Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.all(Dimensions.defaultPadding),
            child: buildBody()
        ),
        bottomNavigationBar: bottomNavBar(),
      ),
    );
  }

  Widget buildBody(){
    if(controller.isStudentProfileLoading.value.isLoading){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Loader(text: 'Loading ...'),
        ],
      );
    }
    else if(controller.isStudentProfileLoading.value.isSuccess){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: (){
                controller.loadStudentProfile();
              },
              child: Text('Retry', style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.red, fontSize: 18),)
          ),
        ],
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          // Obx(
          //   () => InkWell(
          //     onTap: () => Get.toNamed(ParentTutionFeeScreen.routeName),
          //     onLongPress: () => controller.toggleFee(),
          //     child: Container(
          //       margin: const EdgeInsets.only(bottom: 16),
          //       child: paymentDueCard(fee: controller.fee.value),
          //     ),
          //   ),
          // ),
          // pendingCard(),

          GestureDetector(
            onTap: () {
              // Get.to(()=>ParentTutionFeeScreen());
            },
            child: paymentDueCard(fee: controller.fee ?? FeeModel(amount: 1, color: 'orange')), // Provide a default FeeModel if null
          ),

          const SizedBox(height: 25),
          homeActionCard(),
          const SizedBox(height: 25),
          performanceStatsOptions(),
          const SizedBox(height: 22),
          performanceStatsCard(),
          const SizedBox(height: 22),
          GestureDetector(
              onTap: (){
                Get.to(AcademicExamsScreen());
              },
              child: performanceChart()),
        ],
      ),
    );
  }

  Widget bottomNavBar() {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
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
          GestureDetector(
            onTap: () => {
              controller.currentIndex.value = 0
            },
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsConstants.appLogo,
                    height: 20,
                  ),
                  Text(
                    "Sheshya",
                    style: kDark_10_400.copyWith(
                      color: (controller.currentIndex.value == 0) ? const Color.fromARGB(255, 20, 93, 149) : AppColors.unSelectedItemColor,
                      fontWeight: (controller.currentIndex.value == 0)
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.currentIndex.value = 1;
              Get.to(StudentDashboardScreen());
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsConstants.child,
                    colorFilter: ColorFilter.mode(
                        controller.currentIndex.value == 1
                            ? AppColors.selectedItemColor
                            : AppColors.unSelectedItemColor,
                        BlendMode.srcIn),
                  ),
                  Text(
                    "Student",
                    style: kDark_10_400.copyWith(
                      color: (controller.currentIndex.value == 1) ? AppColors.selectedItemColor : AppColors.unSelectedItemColor,
                      fontWeight: (controller.currentIndex.value == 1)
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(AcademicExamsScreen());
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsConstants.academic,
                    colorFilter: ColorFilter.mode(
                        controller.currentIndex.value == 2
                            ? AppColors.selectedItemColor
                            : AppColors.unSelectedItemColor,
                        BlendMode.srcIn),
                  ),
                  Text(
                    "Academic",
                    style: kDark_10_400.copyWith(
                      color: (controller.currentIndex.value == 2) ? AppColors.selectedItemColor : AppColors.unSelectedItemColor,
                      fontWeight: (controller.currentIndex.value == 2)
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // controller.currentIndex.value = 3;
              Get.to(ParentChatboxScreen());
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsConstants.chatbox,
                    colorFilter: ColorFilter.mode(
                        controller.currentIndex.value == 3
                            ? AppColors.selectedItemColor
                            : AppColors.unSelectedItemColor,
                        BlendMode.srcIn),
                  ),
                  Text(
                    "Chatbox",
                    style: kDark_10_400.copyWith(
                      color: (controller.currentIndex.value == 3) ? AppColors.selectedItemColor : AppColors.unSelectedItemColor,
                      fontWeight: (controller.currentIndex.value == 3)
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.currentIndex.value = 4;

              Get.to(const ParentProfileScreen());
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsConstants.user,
                    colorFilter: ColorFilter.mode(
                        controller.currentIndex.value == 4
                            ? AppColors.selectedItemColor
                            : AppColors.unSelectedItemColor,
                        BlendMode.srcIn),
                  ),
                  Text(
                    "Profile",
                    style: kDark_10_400.copyWith(
                      color: (controller.currentIndex.value == 4) ? AppColors.selectedItemColor : AppColors.unSelectedItemColor,
                      fontWeight: (controller.currentIndex.value == 4)
                          ? FontWeight.w500
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container performanceChart() {
    return Container(
      height: 200,
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: AppColors.strokeColor )
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shadows: UiConstants.defaultBoxShadows,
          // shadows: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(.05),
          //     blurRadius: 15,
          //     offset: const Offset(0, 2),
          //     spreadRadius: 5,
          //   )
          // ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //image dalna hai 
          Expanded(
            child: SvgPicture.asset(AssetsConstants.academicPerformance)),
          const SizedBox(height: 12),
          Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: [
                      Text(
                        "Academic Performance",
                        style: darknormal16.copyWith(
                          color: AppColors.bodyTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SvgPicture.asset(Assets.arrowRight),
                    ],
                  ),
        ],
      ),
    );
  }

  SingleChildScrollView performanceStatsCard() {

    if(controller.currentDay.value != (-1)){
      for (int i = 0; i < controller.currentDay.value; i++){
        days[i].status = DayStatus.PAST;
      }
      days[controller.currentDay.value].status = DayStatus.TODAY;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < days.length; i++)
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if(days[i].status == DayStatus.TODAY)Get.to(ActivityScreen());
                  },
                  child: Container(
                    height: 58,
                    width: 38,
                    margin:
                        EdgeInsets.only(right: i == days.length - 1 ? 0 : 26),
                    padding: EdgeInsets.symmetric(
                        horizontal: i == 0 ? 0 : 10, vertical: 8),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: AppColors.strokeColor),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          days[i].dayCode,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: days[i].status == DayStatus.PAST
                                ? const Color(0xFF83898F)
                                : days[i].status == DayStatus.UPCOMING
                                    ? const Color(0xFFBFBFBF)
                                    : const Color(0xFF374957),
                            fontSize: 12,
                            fontWeight: days[i].status == DayStatus.TODAY
                                ? FontWeight.bold
                                : FontWeight.w400,
                          ),
                        ),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: days[i].status == DayStatus.PAST
                              ? const Color(0xFFA7CDFF)
                              : days[i].status == DayStatus.UPCOMING
                                  ? const Color(0xFFD5DAE7)
                                  : const Color(0xFFFF872C),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: days[i].status == DayStatus.TODAY,
                  child: Positioned(
                    top: 0,
                    left: 17,
                    child: SvgPicture.asset(AssetsConstants.polygon),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Row performanceStatsOptions() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Activity',
          style: TextStyle(
            color: Color(0xFF374957),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chevron_left,
              color: Color(0xFF838A8F),
            ),
            SizedBox(width: 4),
            Text(
              'This week',
              style: TextStyle(
                color: Color(0xFF8E8A8F),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4),
            Icon(
              Icons.chevron_right,
              color: Color(0xFF838A8F),
            ),
          ],
        )
      ],
    );
  }

  Row homeActionCard() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // Get.to(StudentDashboardScreen());
              Get.to(StudentDashboard());
              // Get.to(ParentTutionFeeScreen());
              // Get.to(ParentPaymentMethodScreen());
              // Get.to(StudentDashboard);
            },
            child: Container(
              height: Get.height * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: AppColors.strokeColor )
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: SvgPicture.asset(AssetsConstants.studentCorner)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Student Corner",
                        style: darknormal14.copyWith(
                          color: AppColors.bodyTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SvgPicture.asset(Assets.arrowRight),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 19),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(StudentLeaveAttendanceScreen());
            },
            child: Container(
              height: Get.height * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(5)),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: AppColors.strokeColor )
                // shadows: const [
                //   BoxShadow(
                //     color: Color(0x0C000000),
                //     blurRadius: 15,
                //     offset: Offset(0, 2),
                //     spreadRadius: 5,
                //   )
                // ],
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SvgPicture.asset('assets/images/attendance_calendar.svg'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Attendance",
                        style: TextStyle(
                          color: AppColors.bodyTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SvgPicture.asset(Assets.arrowRight),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

Container pendingCard() {
  return Container(
    height: 84.h,
    // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 14.5, vertical: 1),
    decoration: BoxDecoration(
      color: Color(0xFF2C87FF), // Orange background
      borderRadius: BorderRadius.circular(5),
      
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome User",
              style: UiConstants.light_14_400,
            ),
            Text(
              "Explore the AI Ecosystem",
              style: UiConstants.light_14_400,
            ),
          ],
        ),
        // Placeholder for additional widget (e.g., a button or icon)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          child: const Text(
            "🎉", // Robot emoji
            style: TextStyle(fontSize: 28), // Adjust size as needed
  ),
        ),
      ],
    ),
  );
}



Container paymentDueCard({required FeeModel fee}) {
  // Get the current month
  final String currentMonth = DateFormat('MMMM').format(DateTime.now());
  return Container(
    height: 90,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: fee.color == 'orange'
                  ? Colors.orange
                  : fee.color == 'blue'
                    ? Colors.blue
                    : Colors.black,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(width: 1, color: AppColors.strokeColor),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fee.amount == 0
                ? "NO DUE PAYMENT" 
                : "PAYMENT DUE - $currentMonth", 
              style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              fee.amount == 0
                  ? "Yayyy!" 
                  : "₹${fee.amount}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SvgPicture.asset(
          AssetsConstants.rightArrowSquare,
        ),
      ],
    ),
  );
}
}
