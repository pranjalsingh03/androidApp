import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/data/respository/teacher/timetable_repo.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/helper/system_ui.dart';
import 'package:sheshya/theme/app_colors.dart';
import 'package:sheshya/components/custom_snackbar_widget.dart';
import 'package:intl/intl.dart';

class TeacherTimetableScreen extends StatefulWidget {
  const TeacherTimetableScreen({super.key});

  @override
  State<TeacherTimetableScreen> createState() => _TeacherTimetableScreenState();
}

class _TeacherTimetableScreenState extends State<TeacherTimetableScreen> {
  bool isLoading = true;
  List<dynamic>? timetable;
  String selectedDay = '';

  final List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final weekDaysShort = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  @override
  void initState() {
    super.initState();
    selectedDay = DateFormat('EEEE').format(DateTime.now());
    getTimetable();
  }

  Future<void> getTimetable() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await TimetableRepo.getTimetableByDay(selectedDay);
      if (response == null) {
        showCustomSnackBar("Schedule not found");
      } else {
        if (response['data'] != null) {
          setState(() {
            timetable = response['data'];
          });
        } else {
          showCustomSnackBar(response['message'] ?? "Failed to load schedule");
        }
      }
    } catch (e) {
      showCustomSnackBar("Unable to get schedule");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget _buildScheduleForDay(String day) {
    if (timetable == null) {
      return const Center(child: Text('No schedule available'));
    }

    final scheduleForDay = timetable!.where((schedule) => schedule['day'] == day).toList();

    if (scheduleForDay.isEmpty) {
      return const Center(
        child: Text(
          'No Classes Scheduled',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: scheduleForDay.length,
      itemBuilder: (context, index) {
        final schedule = scheduleForDay[index];
        final className = schedule['className']['className'];
        final section = schedule['className']['section'];
        final subject = schedule['subject']['subName'];
        final period = schedule['period']['name'];
        return Container(
          margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.defaultPadding,
              vertical: Dimensions.defaultPadding / 2),
          decoration: kDefaultDecoration,
          child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 20.w,
                child: Text(
                  className,
                  style: kLight_12_500,
                ),
              ),
              title: Text(
                'Section $section',
                style: kDark_14_500,
              ),
              subtitle: Text(
                "$period, $subject",
                style: kDark_12_400.copyWith(
                  color: AppColors.secondaryTextColor,
                  fontWeight: FontWeight.w300,
                ),
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUi.defaultStyle,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text("Timetable"),
        ),
        body: isLoading
            ? const Center(
                child: Loader(
                  text: "Getting your schedule...",
                ),
              )
            : Column(
                children: [
                  Container(
                    height: 47.h,
                    width: Get.width - 32,
                    decoration: kDefaultDecoration,
                    margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.defaultPadding),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        weekDays.length,
                        (index) {
                          final day = weekDays[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: InkWell(
                              onTap: () => setState(() {
                                selectedDay = day;
                                getTimetable();
                              }),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 8,
                                ),
                                child: Text(
                                  weekDaysShort[index],
                                  style: kDark_16_500.copyWith(
                                    color: selectedDay == day
                                        ? AppColors.textColor
                                        : AppColors.secondaryTextColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  k20YGap,
                  Expanded(
                    child: _buildScheduleForDay(selectedDay),
                  ),
                ],
              ),
      ),
    );
  }
}