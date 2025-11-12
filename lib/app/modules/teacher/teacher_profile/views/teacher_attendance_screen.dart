import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/controllers/teacher_profile_controller.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/leave_teacher_screen.dart';
import 'package:sheshya/app/modules/teacher/teacher_profile/views/teacher_all_leaves_screen.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/custom_button_widget.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/assets.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState extends State<TeacherAttendanceScreen> {
  final TeacherProfileController controller =
      Get.find<TeacherProfileController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.reset();
    });
    // controller.initializeMonths();
    // // Ensure selectedMonth is set to a valid value
    // if (controller.selectedMonth.value.isEmpty && controller.monthsName.isNotEmpty) {
    //   controller.selectedMonth.value = controller.monthsName.first;
    // }
    // Set the system UI overlay style
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.dark,
    //   systemNavigationBarColor: Colors.white,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ));
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current location
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text("Attendance"),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    EasyTheme(
                      data: kEasyTheme(context),
                      child: EasyDateTimeLinePicker(
                        focusedDate: controller.selectedDate,
                        currentDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 3)),
                        lastDate: DateTime.now().add(const Duration(days: 5)),
                        disableStrategy: const DisableStrategy.afterToday(),
                        onDateChange: (selectedDate) {
                          controller.updateSelectedDate(selectedDate);
                        },
                        headerOptions: HeaderOptions(
                          headerType: HeaderType.viewOnly,
                          headerBuilder: (context, date, onTap) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  DateFormat('MMMM').format(date),
                                  style: kDark_16_500,
                                ),
                                k8YGap,
                              ],
                            ),
                          ),
                        ),
                        timelineOptions: const TimelineOptions(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.defaultPadding),
                        ),
                      ),
                    ),

                    // Leave Request & Leave Record
                    kdefaultYGap,
                    Row(
                      children: [
                        k16XGap,
                        leaveRequestCard(),
                        k16XGap,
                        leaveRecordsCard(),
                        k16XGap,
                      ],
                    ),
                    kdefaultYGap,
                    GestureDetector(
                      onTap: () => Get.to(() => const TeacherAllLeavesScreen()),
                      child: leaveDetailsCard(),
                    ),
                  ],
                ),
              ),
            ),
            if (controller.isMarkingAttendance)
              Container(
                color: AppColors.backgroundColor,
                child: const Center(
                  child: Loader(text: "Marking Attendance"),
                  
                ),
              ),
          ],
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(Dimensions.defaultPadding),
          child: controller.isTodaysAttendanceGiven &&
                  DateUtils.isSameDay(controller.selectedDate, DateTime.now())
              ? CustomButton(
                  buttonText: "Attendance Given",
                  height: 75.h,
                  onPressed: () {},
                )
              : CustomButton(
                  buttonText: "Mark Attendance",
                  height: 75.h,
                  onPressed: () async {
                    controller.isMarkingAttendance = true;
                    controller.update();
                    try {
                      // Get the current location
                      Position position = await _getCurrentLocation();
                      // Check teacher location before marking attendance
                      await controller.checkTeacherLocation(
                        latitude: position.latitude,
                        longitude: position.longitude,
                      );
                    } catch (e) {
                      showCustomSnackBar(
                        e.toString(),
                        type: SnackBarType.error,
                      );
                    } finally {
                      controller.isMarkingAttendance = false;
                      controller.update();
                    }
                  },
                ),
        ),
      ),
    );
  }

  Expanded leaveRequestCard() {
    return Expanded(
      child: GestureDetector(
        onTap: () => applyForLeave(context),
        child: Container(
          height: 188.h,
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
            ),
          ),
          child: Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Leave Request",
                    style: kLight_14_600,
                  ),
                  SvgPicture.asset(
                    Assets.arrowRight,
                    colorFilter: const ColorFilter.mode(
                      AppColors.inverseTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded leaveRecordsCard() {
    return Expanded(
      child: GestureDetector(
        onTap: ()=>Get.to(() => LeaveRecordsScreen()),
        child: Container(
        height: 188.h,
        padding: const EdgeInsets.all(10),
        decoration: kDefaultDecoration,
        child: Column(
          children: [
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Leave Records",
                  style: kDark_14_600,
                ),
                SvgPicture.asset(
                  Assets.arrowRight,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textColor,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      )
    );
  }

  Container leaveDetailsCard() {
    return Container(
      height: 108.h,
      width: Get.width,
      decoration: kDefaultDecoration,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: Dimensions.defaultPadding),
            child: SvgPicture.asset(Assets.leaveDetail),
          ),
          k16XGap,
          Expanded(
            child: Container(
              height: 108.h,
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.defaultPadding, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Leave Details",
                    style: kDark_14_600,
                  ),
                  k8XGap,
                  SvgPicture.asset(Assets.arrowRight),
                ],
              ),
            ),
          ),
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
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Apply for Leave",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Leave Date",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Obx(
                      () => DropdownButton<String>(
                        value: controller.selectedMonth.value.isNotEmpty
                            ? controller.selectedMonth.value
                            : null,
                        items: controller.monthsName.map((String month) {
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
                const SizedBox(height: 10.0),
                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          controller.monthsWithDays[
                                  controller.selectedMonth.value]?.length ??
                              0, (index) {
                        final day = controller
                            .monthsWithDays[controller.selectedMonth.value]![index];
                        bool isSelected = controller.selectedDatesForLeave
                            .contains(DateTime.parse(day['formattedDate']!));
                        return GestureDetector(
                          onTap: () {
                            DateTime selectedDate =
                                DateTime.parse(day['formattedDate']!);
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
                            margin: const EdgeInsets.only(right: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  day['day']!,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
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
                const SizedBox(height: 20.0),
                const SizedBox(height: 10.0),
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
                const SizedBox(height: 15.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller.onClickingApplyForLeave();
                      // controller.loadOverallAttendanceAnalysis(); // Reload data after applying leave
                    },
                    child: const Text("Apply"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
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