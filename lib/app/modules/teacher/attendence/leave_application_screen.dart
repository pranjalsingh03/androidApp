import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/app/modules/teacher/attendence/components/leave_teacher_card.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class LeaveApplicationScreen extends StatefulWidget {
  const LeaveApplicationScreen({super.key});

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  final AttendanceController controller = Get.find<AttendanceController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch the initial leave data after the first frame is rendered
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.fetchLeaveDataByDate(controller.selectedDate.value.toIso8601String().split('T')[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
        automaticallyImplyLeading: false,
        leading: const AppBarBackButton(),
        actions: [
          Obx(() => !controller.isLoadingClass.value
              ? CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  child: Text(
                    '${controller.selectedClass.value}${controller.selectedSection.value}',
                    style: kLight_10_500,
                  ),
                )
              : const SizedBox.shrink()),
          k16XGap,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
        child: Column(
          children: [
            Material(
              child: EasyDateTimeLine(
                initialDate: controller.selectedDate.value,
                disabledDates: List.generate(
                  365,
                  (index) => DateTime.now().add(Duration(days: index + 1)),
                ),
                onDateChange: (selectedDate) async {
                  controller.updateSelectedDate(selectedDate);
                  await controller.fetchLeaveDataByDate(selectedDate.toIso8601String().split('T')[0]);
                },
                headerProps: EasyHeaderProps(
                  selectedDateStyle: kDark_16_500,
                  monthPickerType: MonthPickerType.switcher,
                  dateFormatter: const DateFormatter.custom("dd MMM yyyy"),
                ),
                dayProps: EasyDayProps(
                  height: 75.h,
                  width: 48.w,
                  dayStructure: DayStructure.dayStrDayNum,
                  todayStyle: DayStyle(
                    dayStrStyle: kDark_14_500,
                    dayNumStyle: kDark_18_700,
                    decoration: BoxDecoration(
                      color: AppColors.inverseTextColor,
                      border: Border.all(
                          color: AppColors.accentColor, width: 1.5),
                      borderRadius: BorderRadius.circular(
                          Dimensions.defaultRoundedCorner),
                    ),
                  ),
                  inactiveDayStyle: DayStyle(
                    dayStrStyle: kDark_14_500,
                    dayNumStyle: kDark_18_700,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(
                          Dimensions.defaultRoundedCorner),
                    ),
                  ),
                  disabledDayStyle: DayStyle(
                    dayStrStyle: kDark_14_500,
                    dayNumStyle: kDark_18_700,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(
                          Dimensions.defaultRoundedCorner),
                    ),
                  ),
                  activeDayStyle: DayStyle(
                    dayStrStyle: kLight_14_500,
                    dayNumStyle: kLight_18_700,
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(
                          Dimensions.defaultRoundedCorner),
                    ),
                  ),
                ),
                activeColor: AppColors.accentColor,
              ),
            ),
            const SizedBox(
              height: Dimensions.defaultPadding,
            ),
            Expanded(
              child: Obx(() => controller.isFetchingLeaveData.value
                  ? const Center(child: Loader(text: "Loading Leaves...",))
                  : controller.leaveStudents.isEmpty
                      ? const Center(
                          child: Text(
                            'No leave applications found',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: controller.leaveStudents.length,
                          itemBuilder: (context, index) {
                            final student = controller.leaveStudents[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: Dimensions.defaultPadding),
                              child: LeaveTeacherCard(student: student),
                            );
                          },
                        )),
            ),
          ],
        ),
      ),
    );
  }
}