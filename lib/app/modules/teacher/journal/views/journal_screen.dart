import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sheshya/app/modules/teacher/journal/controllers/record_journal_controller.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/components/loader.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';
import 'package:sheshya/theme/app_colors.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final JournalController controller = Get.find<JournalController>();

  @override
  void initState() {
    super.initState();
    controller.fetchSchedule();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JournalController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          title: const Text("Daily Journal"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultPadding),
          child: Column(
            children: [
              // Calendar Scroll View
              EasyDateTimeLine(
                initialDate: controller.selectedDate.value,
                disabledDates: List.generate(
                  365,
                  (index) => DateTime.now().add(Duration(days: index + 1)),
                ),
                onDateChange: (selectedDate) {
                  controller.updateSelectedDate(selectedDate);
                },
                headerProps: EasyHeaderProps(
                  selectedDateStyle: kDark_16_500,
                  monthPickerType: MonthPickerType.switcher,
                  monthStyle: TextStyle(
                    fontSize: 16.sp,
                  ),
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
                      border: Border.all(color: AppColors.accentColor, width: 1.5),
                      borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
                    ),
                  ),
                  inactiveDayStyle: DayStyle(
                    dayStrStyle: kDark_14_500,
                    dayNumStyle: kDark_18_700,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
                    ),
                  ),
                  disabledDayStyle: DayStyle(
                    dayStrStyle: kDark_14_500,
                    dayNumStyle: kDark_18_700,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
                    ),
                  ),
                  activeDayStyle: DayStyle(
                    dayStrStyle: kLight_14_500,
                    dayNumStyle: kLight_18_700,
                    decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(Dimensions.defaultRoundedCorner),
                    ),
                  ),
                ),
                activeColor: AppColors.accentColor,
              ),
              kdefaultYGap,
              k4YGap,
              Text(
                "My Classes",
                style: kDark_16_500,
              ),
              k6YGap,
              Obx(() => controller.isLoading.value
                  ? const Loader(text: "Loading Classes...")
                  : Expanded(
                      child: ListView.builder(
                        itemCount: controller.schedule.length,
                        itemBuilder: (context, index) {
                          final item = controller.schedule[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.strokeColor, width: 1),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    "${item['className']['className']}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "Section ${item['className']['section']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  "Period ${item['period']['name']}, ${item['subject']['subName']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    if (!item['isRecorded']) {
                                      _showUpdateRecordDialog(controller, item);
                                    }
                                  },
                                  child: Text(
                                    item['isRecorded'] ? "Marked" : "Add",
                                    style: TextStyle(
                                      color: item['isRecorded'] ? Colors.orange : Colors.blue,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  void _showUpdateRecordDialog(JournalController controller, dynamic item) {
    final TextEditingController descriptionController = TextEditingController();

    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9, // Increase the width
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Class & Section Title
              Text(
                "${item['className']['className']} ${item['className']['section']}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              // Period & Subject
              Text(
                "${item['period']['name']} Period, ${item['subject']['subName']}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              // Date Display
              Text(
                "Date: ${controller.selectedDate.value.day}/${controller.selectedDate.value.month}/${controller.selectedDate.value.year}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              // Description Input
              Container(
                height: 120,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    fillColor: Color(0xFFE0E0E0),
                    border: InputBorder.none,
                    hintText: "Write description..",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Create Journal Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    // Show loader

                    //it is in teh black background i dont want black background
                    
                    Get.dialog(
                     Scaffold(
            body: Center(child: Loader(text: "Saving Journal...")),
          )
                    );

                    // Submit the record
                    await controller.updateRecord(
                      sclassName: item['className']['_id'],
                      subject: item['subject']['_id'],
                      description: descriptionController.text,
                      periodId: item['period']['_id'],
                    );

                    // Close the loader
                    Get.back();

                    // Close the dialog
                    Get.back();

                    // Refresh the schedule
                    controller.fetchSchedule();
                  },
                  child: const Text(
                    "Create Journal",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}