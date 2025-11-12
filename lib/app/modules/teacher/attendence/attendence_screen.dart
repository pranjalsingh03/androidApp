import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/modules/teacher/Attendence/mark_attendance_screen.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/app/modules/teacher/attendence/leave_application_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/app/modules/teacher/Attendence/components/leave_mark_card.dart';
import 'package:sheshya/app/modules/teacher/Attendence/components/student_count_card.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late AttendanceController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AttendanceController>();
    fetchData();
  }

  Future<void> fetchData() async {
    await controller.fetchTeacherProfile();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(
      builder: (controller) => SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            AppBar(
              title: const Text("Attendance"),
              automaticallyImplyLeading: false,
              leading: const AppBarBackButton(),
              actions: [
                !controller.isLoadingClass.value
                    ? CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: Text(
                          '${controller.selectedClass.value}${controller.selectedSection.value}',
                          style: kLight_10_500,
                        ),
                      )
                    : const SizedBox.shrink(),
                k16XGap,
              ],
            ),
            // Body
            controller.isLoadingClass.value
                ? const Center(child: Loader(text: "Loading..."))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(children: [
                        const SizedBox(
                          height: Dimensions.defaultPadding,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: StudentCountCard(
                              text: 'Student Present',
                              bgcolor: Colors.white,
                              num: controller.presentCount.value.toString(),
                            )),
                            const SizedBox(
                              width: Dimensions.defaultPadding,
                            ),
                            Expanded(
                                child: StudentCountCard(
                                    text: 'Student Absent ',
                                    bgcolor: const Color(0xFFC3C5D3),
                                    num: controller.absentCount.value.toString()))
                          ],
                        ),
                        kdefaultYGap,
                        EasyTheme(
                          data: kEasyTheme(context),
                          child: EasyDateTimeLinePicker(
                            focusedDate: controller.selectedDate.value,
                            currentDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 3)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 5)),
                            disableStrategy: const DisableStrategy.afterToday(),
                            onDateChange: (selectedDate) {
                              controller.updateSelectedDate(selectedDate);
                            },
                            headerOptions: HeaderOptions(
                              headerType: HeaderType.viewOnly,
                              headerBuilder: (context, date, onTap) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.defaultPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        DateFormat('MMMM').format(date),
                                        style: kDark_16_500,
                                      ),
                                      k8YGap,
                                    ],
                                  ),
                                );
                              },
                            ),
                            timelineOptions: const TimelineOptions(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.defaultPadding),
                            ),
                          ),
                        ),
                        kdefaultYGap,
                        LeaveMarkCard(
                            text: 'Mark Attendance',
                            press: () {
                              Get.to(() => const MarkAttendanceScreen());
                            }),
                        const SizedBox(
                          height: Dimensions.defaultPadding,
                        ),
                        LeaveMarkCard(
                            text: 'Leave Application',
                            press: () {
                              Get.to(() =>  const LeaveApplicationScreen());
                            }),
                      ]),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}