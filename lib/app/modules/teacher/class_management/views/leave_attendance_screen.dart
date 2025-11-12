import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/data/const_data/date.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/app/modules/teacher/attendence/components/mont_year_pickup_dialog.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class LeaveAttendanceScreen extends StatefulWidget {
  LeaveAttendanceScreen({super.key});

  @override
  _LeaveAttendanceScreenState createState() => _LeaveAttendanceScreenState();
}

class _LeaveAttendanceScreenState extends State<LeaveAttendanceScreen> {
  final ScrollController scrollController = ScrollController();
  final AttendanceController controller = Get.find<AttendanceController>();

  @override
  void initState() {
    super.initState();
    _fetchAttendanceForSelectedMonth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Class Management',
            textScaler: TextScaler.noScaling,
          ),
          leading: const AppBarBackButton()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: kDefaultDecorationBordered,
                      child: Column(
                        children: [
                          Obx(() => Text(
                                '${controller.totalDays}',
                                style: kDark_18_600,
                              )),
                          Text(
                            'Working Days',
                            style: kSecondary_10_500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  k16XGap,
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: kDefaultDecorationBordered,
                      child: Column(
                        children: [
                          Obx(() => Text(
                                '${controller.presentDays}',
                                style: kDark_18_600,
                              )),
                          Text(
                            'Present',
                            style: kSecondary_10_500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  k16XGap,
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: kDefaultDecorationBordered,
                      child: Column(
                        children: [
                          Obx(() => Text(
                                '${controller.absentDays}',
                                style: kDark_18_600,
                              )),
                          Text(
                            'Absent',
                            style: kSecondary_10_500,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: Dimensions.defaultPadding,
              ),
              SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Obx(() => Text(
                                  DateFormat.MMMM().format(DateTime(0, controller.selectedMonth.value)),
                                  style: darksemibold16,
                                )),
                            IconButton(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: Dimensions.defaultPadding,
                              ),
                              onPressed: () {
                                _showMonthYearPicker(context);
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                size: Dimensions.defaultPadding,
                              ),
                              onPressed: () {
                                controller.decrementMonth();
                                _fetchAttendanceForSelectedMonth();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: Dimensions.defaultPadding,
                              ),
                              onPressed: () {
                                controller.incrementMonth();
                                _fetchAttendanceForSelectedMonth();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Dimensions.defaultPadding,
              ),
              // Pie Chart
              Container(
                width: Get.width - 32,
                padding: const EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                child: Column(
                  children: [
                    recordTileHeader(),
                    const SizedBox(height: 28),
                    recordTotalStats(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMonthYearPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return MontYearPickupDialog(
            controller: controller, years: years, months: months);
      },
    ).then((_) {
      _fetchAttendanceForSelectedMonth();
    });
  }

  void _fetchAttendanceForSelectedMonth() {
    final studentId = "67a65db163d7c6e04dc7e797"; // Replace with the actual student ID
    final month = DateFormat.MMMM().format(DateTime(0, controller.selectedMonth.value));
    controller.fetchStudentAttendance(studentId, month);
  }

  Column recordTotalStats() {
    return Column(
      children: [
        Obx(() => recordCardTitle(
            bgColor: AppColors.primaryColor, text: "Working Days", value: "${controller.totalDays}")),
        Obx(() => recordCardTitle(
            bgColor: AppColors.primaryLowVersionColor,
            text: "Present",
            value: "${controller.presentDays}")),
        Obx(() => recordCardTitle(
            bgColor: AppColors.accentColor, text: "Absent", value: "${controller.absentDays}")),
      ],
    );
  }

  Row recordCardTitle({
    required Color bgColor,
    required String text,
    required String value,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 7,
          backgroundColor: bgColor,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: kDark_16_600,
          ),
        ),
        Text(
          value,
          style: kSecondary_16_500,
        )
      ],
    );
  }

  Row recordTileHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      // Header
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance Record",
              style: kDark_14_500,
            ),
            const SizedBox(height: 4),
            Obx(() => Text(
                  "1st ${DateFormat.MMMM().format(DateTime(0, controller.selectedMonth.value))} - 30th ${DateFormat.MMMM().format(DateTime(0, controller.selectedMonth.value))}",
                  style: kDark_10_500,
                )),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 0.5, color: AppColors.cardBorderColor),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "This Week",
                style: kSecondary_12_500,
              ),
              const SizedBox(width: 9),
              const Icon(
                CupertinoIcons.chevron_down,
                color: AppColors.secondaryColor,
                size: 18,
              )
            ],
          ),
        ),
      ],
    );
  }
}