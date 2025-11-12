import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/const_data/date.dart';
import 'package:sheshya/app/modules/teacher/attendence/components/class_pickup_dialog.dart';
import 'package:sheshya/app/modules/teacher/attendence/components/date_card.dart';
import 'package:sheshya/app/modules/teacher/attendence/components/mont_year_pickup_dialog.dart';
import 'package:sheshya/app/modules/teacher/attendence/components/student_card.dart';
import 'package:sheshya/app/modules/teacher/attendence/components/student_count_card.dart';
import 'package:sheshya/app/modules/teacher/attendence/controllers/attendance_controller.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constant.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';

// Define weekdays
const List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

class AttendanceReportScreen extends StatelessWidget {
  AttendanceReportScreen({super.key});
  final AttendanceController controller = Get.find<AttendanceController>();
  final ScrollController scrollController = ScrollController();

  void _centerSelectedDate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int index =
          DateTime.now().difference(controller.selectedDate.value).inDays + 30;
      double position =
          index * 58.0; // 58 is an estimate of the width of each date tile
      double screenWidth = Get.context!.size!.width;
      double centerPosition = position -
          screenWidth / 2 +
          29.0; // 29 is half of the estimated tile width
      scrollController.jumpTo(centerPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    // _centerSelectedDate();
    // controller.selectedDate.listen((selectedDate) {
    //   int index = DateTime.now().difference(selectedDate).inDays + 30;
    //   scrollController.animateTo(
    //     index * 58.0, // 58 is an estimate of the width of each date tile
    //     duration: const Duration(milliseconds: 300),
    //     curve: Curves.easeInOut,
    //   );
    // });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance"),
        automaticallyImplyLeading: false,
        leading: AppBarBackButton(),
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
            kdefaultYGap,
            Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: StudentCountCard(
                            num: (controller.presentCount).toString(),
                            text: 'Student Present',
                            bgcolor: Colors.white,
                          )),
                          const SizedBox(
                            width: Dimensions.defaultPadding,
                          ),
                          Expanded(
                              child: StudentCountCard(
                                  //absent = totalstudent-leave-presentstudent
                                  num: (controller.absentCount)
                                      .toString(),
                                  text: 'Student Absent ',
                                  bgcolor: const Color(0xFFC3C5D3)))
                        ],
                      ),
            kdefaultYGap,
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // const LeaveTeacherCard(),
                      const SizedBox(
                        height: Dimensions.defaultPadding,
                      ),
                      
                      const SizedBox(
                        height: Dimensions.defaultPadding,
                      ),
                        const Text(
                        'Absent Students',
                        style: lightnormal16,
                        textScaler: TextScaler.noScaling,
                        ),
                        const SizedBox(
                        height: Dimensions.defaultPadding,
                        ),
                        GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.absentStudents.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: Dimensions.defaultPadding,
                          crossAxisSpacing: Dimensions.defaultPadding,
                          mainAxisExtent: 60,
                        ),
                        itemBuilder: (context, index) {
                          final student = controller.absentStudents[index];
                          return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.strokeColor, width: 1),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                            backgroundImage: student.imageUrl != ""
                              ? NetworkImage(student.imageUrl)
                              : null,
                            child: student.imageUrl == ""
                              ? const Icon(Icons.person)
                              : null,
                            ),
                            title: Text(student.name),
                          ),
                          );
                          },
                        ),
                        const SizedBox(
                        height: Dimensions.defaultPadding,
                        ),
                        const Text(
                        'Present Students',
                        style: lightnormal16,
                        textScaler: TextScaler.noScaling,
                        ),
                        const SizedBox(
                        height: Dimensions.defaultPadding,
                        ),
                        GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.presentStudents.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: Dimensions.defaultPadding,
                          crossAxisSpacing: Dimensions.defaultPadding,
                          mainAxisExtent: 60,
                        ),
                        itemBuilder: (context, index) {
                          final student = controller.presentStudents[index];
                          return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.strokeColor, width: 1),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                            backgroundImage: student.imageUrl != ""
                              ? NetworkImage(student.imageUrl)
                              : null,
                            child: student.imageUrl == ""
                              ? const Icon(Icons.person)
                              : null,
                            ),
                            title: Text(student.name),
                          ),
                          );
                        },
                        ),
                      const SizedBox(
                        height: Dimensions.defaultPadding,
                      ),
                      const SizedBox(
                        height: Dimensions.defaultPadding,
                      ),
                      const SizedBox(
                        height: Dimensions.defaultPadding,
                      ),
                      
                    ]),
              ),
            ),
          ),
        ],
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
    );
  }

  void _showClassPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ClassPickupDialog(
          controller: controller,
          classes: ['Class 1', 'Class 2', 'Class 3'], // Example class list
          sections: ['Section A', 'Section B', 'Section C'], // Example sections
        );
      },
    );
  }
}
