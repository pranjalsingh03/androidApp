import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets_constants.dart';
import 'package:sheshya/constants/ui_constants_old.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/constants/assets.dart';

import 'leave_attendance_controller.dart';
import 'overall_attendance_analysis_res_model.dart';

class StudentLeaveAttendanceScreen extends GetView<LeaveAttendanceController> {
  static const routeName = "/student-leave-attendance";

  @override
  Widget build(BuildContext context) {
    Get.put(LeaveAttendanceController());

    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        title: const Text(
          "Leave & Attendance",
          style: UiConstants.appBarTitle,
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => (controller.isOverallAttendanceAnalysisLoading.value.isLoading)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Loader(text: "Loading..."),
                      const SizedBox(height: 19),
                    ],
                  ),
                )
              : (controller.isOverallAttendanceAnalysisLoading.value.isError)
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.loadOverallAttendanceAnalysis();
                        },
                        child: Text('No Data Available. Tap to retry.'),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // * Attendance Card
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              attendanceCard(
                                  title: "Present",
                                  value: controller
                                          .overallAttendanceAnalysisResModel
                                          ?.data
                                          ?.present ??
                                      0),
                              attendanceCard(
                                  title: "Absent",
                                  value: controller
                                          .overallAttendanceAnalysisResModel
                                          ?.data
                                          ?.absent ??
                                      0),
                              attendanceCard(
                                  title: "Leaves",
                                  value: controller
                                          .overallAttendanceAnalysisResModel
                                          ?.data
                                          ?.leave ??
                                      0),
                            ],
                          ),
                          const SizedBox(height: 25),
                          // * Date Range
                          Obx(
                            () => (controller.isFilteredAttendanceAnalysisLoading
                                    .value.isLoading)
                                ? Column(
                                    children: [
                                      Loader(text: "Loading..."),
                                      const SizedBox(height: 19),
                                    ],
                                  )
                                : (controller.isFilteredAttendanceAnalysisLoading
                                        .value.isError)
                                    ? Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            controller
                                                .loadFilteredAttendanceAnalysis();
                                          },
                                          child: Text('No Data Available. Tap to retry.'),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          dateRange(context),
                                          const SizedBox(height: 19),
                                          // * Day Cards
                                          // dayCardsList(),
                                          // * Attendance Records
                                          Container(
                                            width: Get.width - 32,
                                            padding: const EdgeInsets.all(20),
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: BorderSide(
                                                  color: AppColors.cardBorderColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                recordTileHeader(),
                                                const SizedBox(height: 28),
                                                recordTotalStats(),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                        ],
                                      ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 28.0, left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            cardButtons(
                text: "Apply For Leave",
                onPress: () => {applyForLeave(context)}),
            cardButtons(
                text: "View Leave Records",
                onPress: () => {
                      controller.isOverallAttendanceAnalysisLoading.value =
                          RxStatus.loading(),
                      controller.onClickingViewLeaveRecords(context)
                    }),
          ],
        ),
      ),
    );
  }

  Widget cardButtons({
    required String text,
    required VoidCallback onPress,
  }) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 52,
        width: (Get.width - 32 - 8) / 2,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: AppColors.cardBorderColor,
              width: 1.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: UiConstants.dark_12_500,
          ),
        ),
      ),
    );
  }

  Column recordTotalStats() {
    return Column(
      children: [
        recordCardTitle(
            bgColor: AppColors.primaryColor,
            text: "Leave",
            value: controller.overallAttendanceAnalysisResModel?.data?.leave ??
                0),
        recordCardTitle(
            bgColor: AppColors.primaryLowVersionColor,
            text: "Present",
            value:
                controller.overallAttendanceAnalysisResModel?.data?.present ??
                    0),
        recordCardTitle(
            bgColor: AppColors.accentColor,
            text: "Absent",
            value:
                controller.overallAttendanceAnalysisResModel?.data?.absent ??
                    0),
      ],
    );
  }

  Row recordCardTitle({
    required Color bgColor,
    required String text,
    required int value,
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
            style: UiConstants.dark_16_600,
          ),
        ),
        Text(
          value.toString(),
          style: UiConstants.secondary_16_500,
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
        const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance Record",
              style: UiConstants.dark_14_500,
            ),
          ],
        ),
      ],
    );
  }

  Widget dateRange(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: Obx(
              () => Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Text(
                          "Calendar",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(width: 24), // To align the title properly
                      ],
                    ),
                    SizedBox(height: 8.0),

                    // Year Selection Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left),
                          onPressed: () {
                            if (controller.currentIndex.value > 0)
                              controller.currentIndex.value--;
                            controller.selectedYear.value =
                                controller.years[controller.currentIndex.value];
                          },
                        ),
                        Text(
                          controller.years[controller.currentIndex.value]
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {
                            if (controller.currentIndex.value <
                                controller.years.length - 1)
                              controller.currentIndex.value++;
                            controller.selectedYear.value =
                                controller.years[controller.currentIndex.value];
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),

                    // Months Grid
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: controller.months.map((month) {
                        bool isSelected = month ==
                            controller.months[
                                controller.selectedMonthForAttendance.value - 1];
                        return GestureDetector(
                          onTap: () {
                            controller.selectedMonthForAttendance.value =
                                controller.months.indexOf(month) + 1;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              month,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 16.0),

                    // Pick Month Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          print(
                              "Selected Year: ${controller.selectedYear.value}, Month: ${controller.selectedMonthForAttendance.value}");
                          controller.loadFilteredAttendanceAnalysis();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Pick Month",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.months[
                    controller.selectedMonthForAttendance.value - 1],
                style: UiConstants.dark_16_500,
              ),
              const SizedBox(width: 9),
              SvgPicture.asset(
                AssetsConstants.arrowDown,
                width: 18,
                height: 18,
              )
            ],
          ),
          const Spacer(),
          SvgPicture.asset(Assets.arrowRight, width: 18, height: 18)
        ],
      ),
    );
  }

  Container dayCard({
    required String dayCode,
    required int day,
    Color bgColor = Colors.white,
  }) {
    return Container(
      width: 54,
      height: 100,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: ShapeDecoration(
        color: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: bgColor == Colors.white ? 1 : 0,
              color: AppColors.cardBorderColor),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dayCode,
            style: bgColor == AppColors.accentColor
                ? UiConstants.light_14_700
                : UiConstants.dark_14_700,
          ),
          Text(
            day.toString(),
            style: bgColor == AppColors.accentColor
                ? UiConstants.light_18_700
                : UiConstants.dark_18_700,
          )
        ],
      ),
    );
  }

  Container attendanceCard({required String title, required int value}) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: AppColors.cardBorderColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value.toString(),
            style: UiConstants.dark_18_500.copyWith(fontSize: 20),
          ),
          Text(
            title,
            style: UiConstants.secondary_10_500,
          )
        ],
      ),
    );
  }

  void applyForLeave(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Apply for Leave",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Leave Date",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => DropdownButton<String>(
                        value: controller.selectedMonth.value,
                        items: controller.monthsName.value.map((String month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text(month),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.selectedMonth.value = newValue!;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          controller.monthsWithDays[
                                  controller.selectedMonth.value]?.length ??
                              0, (index) {
                        final day = controller
                            .monthsWithDays[controller.selectedMonth.value]![index];
                        bool isSelected = controller.selectedDatesForLeave
                            .contains(DateTime.parse(day['formattedDate']));
                        return GestureDetector(
                          onTap: () {
                            DateTime selectedDate =
                                DateTime.parse(day['formattedDate']);
                            if (isSelected) {
                              controller.selectedDatesForLeave
                                  .remove(selectedDate);
                            } else {
                              controller.selectedDatesForLeave
                                  .add(selectedDate);
                            }
                          },
                          child: Container(
                            width: 50.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.blue : Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            margin: EdgeInsets.only(right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  day['day'],
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  day['date'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(height: 10.0),
                TextField(
                  maxLines: 4,
                  controller: controller.reasonForLeaveTextController,
                  decoration: InputDecoration(
                    hintText: "Reason",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.onClickingApplyForLeave();
                      controller.loadOverallAttendanceAnalysis(); // Reload data after applying leave
                    },
                    child: Text("Apply"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}